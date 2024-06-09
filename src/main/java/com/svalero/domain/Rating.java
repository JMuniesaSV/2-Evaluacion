package com.svalero.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Rating {
    private int idRating;
    private int idUser;
    private int idMovie;
    private int rating;
    private String review;
}
