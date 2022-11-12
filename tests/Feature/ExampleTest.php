<?php

it('has a home page', function () {
    $response = $this->get('/');

    $response->assertStatus(200);
});
