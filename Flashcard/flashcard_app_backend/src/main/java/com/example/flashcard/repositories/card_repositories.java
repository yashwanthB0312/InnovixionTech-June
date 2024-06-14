package com.example.flashcard.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;
import com.example.flashcard.model.card_model;
import org.springframework.stereotype.Repository;

@Repository
public interface card_repositories extends MongoRepository<card_model, String> {
}
