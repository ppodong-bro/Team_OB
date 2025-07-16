package com.oracle.oBootBoard03.dto;

import java.time.LocalDate;
import lombok.Data;

@Data
public class BoardDto {
	private int board_no;
	private String title;
	private String content;
	private int empno;
	private int read_count;
	private int ref;
	private int re_lvl;
	private int re_step;
	private LocalDate in_date;
}
