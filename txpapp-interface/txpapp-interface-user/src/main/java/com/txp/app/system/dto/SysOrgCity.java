package com.txp.app.system.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * th
 */
@Data
public class SysOrgCity
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private Long id;
  private Long orgId;
  private Long cityId;

  
}
