package org.example.tickets.controller;


import org.example.tickets.service.ReviewService;
import org.example.tickets.model.User;
import org.example.tickets.service.UserService;
import org.example.tickets.model.Review;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/review")
public class ReviewController {
    private final ReviewService reviewService;
    private final UserService userService;

    @Autowired
    public ReviewController(ReviewService reviewService, UserService userService) {
        this.reviewService = reviewService;
        this.userService = userService;
    }

    @PostMapping
    public ResponseEntity<?> addReview(@RequestBody Review review) {
        try {
            if (review.getUser() == null || review.getUser().getId() == null || review.getUser().getId() == 0) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("User ID is required.");
            }
            User user = userService.getUserById(review.getUser().getId());
            review.setUser(user);

            // Сохраняем отзыв
            Review savedReview = reviewService.addReview(review);
            return ResponseEntity.ok(savedReview);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error adding review: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<List<Review>> getAllReviews() {
        try {
            List<Review> reviews = reviewService.getAllReviews();
            return ResponseEntity.ok(reviews);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
