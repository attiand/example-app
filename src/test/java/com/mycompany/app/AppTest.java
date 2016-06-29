package com.mycompany.app;

import static org.junit.Assert.*;

import org.junit.Test;

public class AppTest {

	@Test
	public void shouldReturnUltimateQuestionOfLife() {
		App app = new App();
		assertEquals(44, app.foo());
	}
}
