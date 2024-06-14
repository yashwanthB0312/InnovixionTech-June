package com.example.flashcard.service;

import com.example.flashcard.model.card_model;
import com.example.flashcard.repositories.card_repositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class card_service {
    @Autowired
    private card_repositories res;

    public card_model addCard(card_model task) {
        return res.save(task);
    }

    public List<card_model> findAllTask(){
        return res.findAll();
    }
    public void deleteCard(String id) {
        res.deleteById(id);
    }

}
