package com.E1I4.project.storeBoard.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString

public class TotalReview {
	private int reviewCount;
	private double sumStar;
	private double avgStar;
}
