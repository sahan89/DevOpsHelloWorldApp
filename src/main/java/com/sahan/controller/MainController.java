package com.sahan.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/mainController")
public class MainController {
    private final String APPLICATION_JSON = "application/json";

    @RequestMapping(value = "/index", method = RequestMethod.GET, produces = {APPLICATION_JSON})
    public String index() {
        return "Hello World!";
    }
}
