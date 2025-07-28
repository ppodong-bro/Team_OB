package com.WiseForce.AssemERP.domain.km;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Objects;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Embeddable
public class Purchase_Item_Id {

    private int purchase_No;
    private int parts_No;

}
