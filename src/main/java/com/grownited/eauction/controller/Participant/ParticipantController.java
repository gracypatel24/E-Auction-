package com.grownited.eauction.controller.Participant;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ParticipantController {

	@GetMapping("/participant/participant-dashboard")
	public String participantDashboard( ) {
		return "participant/ParticipantDashboard";
	}
	
}