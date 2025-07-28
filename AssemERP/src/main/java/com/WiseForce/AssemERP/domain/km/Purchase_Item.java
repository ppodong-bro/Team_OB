package com.WiseForce.AssemERP.domain.km;

import java.math.BigDecimal;
import jakarta.persistence.*;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "PURCHASE_ITEM")
@Getter
@Setter
@NoArgsConstructor  // JPA용 기본 생성자
public class Purchase_Item {

    @EmbeddedId
    private Purchase_Item_Id purchase_Item_Id;
    private int purchase_Item_Cnt;
    private int purchase_Item_Cost;
    private int purchase_Item_Incnt;
}