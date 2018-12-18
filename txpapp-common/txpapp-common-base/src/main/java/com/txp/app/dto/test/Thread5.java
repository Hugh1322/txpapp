package com.txp.app.dto.test;

import lombok.Data;

/**
 * Created by tianh on 2018/8/24.
 */
@Data
public class Thread5 extends Thread {

    private String curname;

    @Override
    public void run() {
        super.run();
        System.out.println("curname;" + curname + "\t" + ",name:" + getName());

    }

    public static void main(String[] agrs) throws InterruptedException {
        Thread5 t1 = new Thread5();
        t1.setName("t1");
        t1.setCurname("t1name");
        Thread5 t2 = new Thread5();
        t2.setName("t2");
        t2.setCurname("t2name");
        Thread5 t3 = new Thread5();
        t3.setName("t3");
        t3.setCurname("t3name");

        t1.start();
        t1.join();
        t2.start();
        t2.join();
        t3.start();
    }
}
