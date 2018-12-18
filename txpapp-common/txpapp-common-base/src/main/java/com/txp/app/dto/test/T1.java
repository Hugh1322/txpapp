package com.txp.app.dto.test;

import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by tianh on 2018/8/24.
 */
public class T1 {

//    public static void main(String[] args) {
//        T5 t5 = new T5();
//        t5.setName("t5");
//        t5.setSex(5);
//        t5.setCount(5);
//
//        t(t5);
//        System.out.println(t5.getName() + "\t" + t5.getSex() + "\t" +t5.getCount());
//        String s1 = "s1";
//        String ss1 = new String("ss1");
//        t2(s1);
//        t2(ss1);
//        System.out.println(s1);
//        System.out.println(ss1);
//    }

    private static void t(T5 t5) {
        t5.setName("t6");
        t5.setCount(6);
        t5.setSex(6);
    }

    private static void t2(String s) {
        s = "s2";
    }

    public static void change(int []a){
        a[0]=50;
    }
//    public static void main(String[] args) {
//        int []a={10,20};
//        System.out.println(a[0]);
//        change(a);
//        System.out.println(a[0]);
//    }

    public static void change(Emp emp)
    {
        emp.age = 50;
        emp = new Emp();//再创建一个对象
        emp.age=100;
    }

    public static void change2(List<Emp> list) {
        list.remove(0);
        list = new ArrayList<>();
        list.add(new Emp());
        list.add(new Emp());
    }

    public static void main(String[] args) {
        Emp emp = new Emp();
        emp.age = 100;
        System.out.println(emp.age); //100
        change(emp);
        System.out.println(emp.age); //100
        change(emp);
        System.out.println(emp.age); //100

        List<Emp> list = new ArrayList<>();
        list.add(new Emp());
        list.add(new Emp());
        list.add(new Emp());
        list.add(new Emp());
        change2(list);
        System.out.println(list.size()); //2

        final String outUniqueId = "aejwhe_RONGRENZHENG";
        final String order_id = outUniqueId.replace("_RONGRENZHENG","");
        System.out.println(order_id);
    }
}
class Emp {
    public int age;
}