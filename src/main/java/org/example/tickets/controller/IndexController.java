package org.example.tickets.controller;

import org.example.tickets.service.StationService;
import org.example.tickets.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

@Controller
public class IndexController {

    private final UserService userService;
    private final StationService stationService;

    public IndexController(UserService userService, StationService stationService) {
        this.userService = userService;
        this.stationService = stationService;
    }

//    public IndexController(UserService userService) {
//        this.userService = userService;
//    }

    @GetMapping("/")
    public String redirectToHome() {
        return "redirect:/home";
    }

    @GetMapping("/signin")
    public String showSigninPage() {
        return "signin";
    }

    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup";
    }

    @GetMapping("/home")
    public String showHomePage() {
        return "home";
    }

    @GetMapping("/contact")
    public String showContactPage() {
        return "contact";
    }

    @GetMapping("/userHome")
    public String showUserPage() {
        return "userHome";
    }

    @GetMapping("/adminHome")
    public String showAdminPage() {
        return "adminHome";
    }

    @GetMapping("/serviceAdmin")
    public String showServicesPage() {
        return "serviceAdmin";
    }

    @GetMapping("/adminClients")
    public String showAdminClientsPage() {
        return "adminClients";
    }

    @GetMapping("/reviews")
    public String showReviewsPage() {
        return "reviews";
    }

    @GetMapping("/recordAdmin")
    public String showRecordAdminPage() {
        return "recordAdmin";
    }

    @GetMapping("/serviceUser")
    public String showServiceUserPage() {
        return "serviceUser";
    }

    @GetMapping("/master")
    public String showMasterPage() {
        return "master";
    }

    @GetMapping("/video")
    public String showVideoPage() {
        return "video";
    }

    @GetMapping("/statistic")
    public String showStatisticPage() {
        return "statistic";
    }

    @GetMapping("/userMaster")
    public String showUserMasterPage() {
        return "userMaster";
    }

    @GetMapping("/booking")
    public String showBookingPage() {
        return "booking";
    }

    @GetMapping("/adminStations")
    public String showAdminStationsPage(Model model) {
        model.addAttribute("stations", stationService.getAllStations());
        return "adminStations";
    }

    @GetMapping("/adminTrains")
    public String showAdminTrainsPage() {
        return "adminTrains";
    }

    @GetMapping("/seatSelection")
    public String showSeatSelectionPage() {
        return "seatSelection";
    }

    @GetMapping("/routeSchedule")
    public String showRouteSchedulePage() {
        return "routeSchedule";
    }

    @GetMapping("/adminTickets")
    public String showAdminTicketsPage() {
        return "adminTickets";
    }

    @GetMapping("/payment")
    public String showPaymentPage() {
        return "payment";
    }
}

