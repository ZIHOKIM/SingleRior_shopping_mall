package com.E1I4.project.mainPage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.E1I4.project.mainPage.model.service.MainPageService;

@Controller
public class MainPageController {
	
	@Autowired
	private MainPageService mainService;
}
