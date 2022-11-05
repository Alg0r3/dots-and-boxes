.PHONY: install clean lint test help

.DEFAULT_GOAL = help

install:								## Install the project dependencies if they aren't already
	composer install
	npm install

clean:									## Remove the project dependencies
	@rm -rf ./vendor ./node_modules ./coverage

lint: ./vendor 							## Lint the project
	composer validate
	./vendor/bin/pint --test
	./vendor/bin/phpstan analyze -c phpstan.neon --xdebug

test: ./vendor							## Run all the tests
	mkdir -p ./coverage
	php artisan test --parallel --coverage-html ./coverage --min=100

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
