package com.txp.app.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by gx on 2017/8/9.
 */
@Data
public class MessageDto implements Serializable {
    private static final long serialVersionUID = -1530104582164541858L;

    private String businessScenario;
    private String phone;
    private String msg;
    private String type;
}
