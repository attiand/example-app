package com.mycompany.app;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class CalculatorTest {

	@DisplayName("should sum positive numbers")
	@Test
	public void shouldSumPositiveNumbers() {
		assertThat(Calculator.sum(2, 3)).isEqualTo(5);
	}

	@DisplayName("should sum positive and negative numbers")
	@Test
	public void shouldSumPositiveAndNegativeNumbers() {
		assertThat(Calculator.sum(2, -3)).isEqualTo(-1);
	}
}

