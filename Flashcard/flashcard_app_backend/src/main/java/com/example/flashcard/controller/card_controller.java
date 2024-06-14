package com.example.flashcard.controller;

import com.example.flashcard.model.card_model;
import com.example.flashcard.service.card_service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/cards")
public class card_controller {
    @Autowired
    private card_service service;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<card_model> create(@RequestBody card_model card) {
        card_model createdCard = service.addCard(card);
        return new ResponseEntity<>(createdCard, HttpStatus.CREATED);
    }

    @GetMapping
    public List<card_model> getTask(){
        return service.findAllTask();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCard(@PathVariable String id) {
        service.deleteCard(id);
        return ResponseEntity.noContent().build();
    }
}
