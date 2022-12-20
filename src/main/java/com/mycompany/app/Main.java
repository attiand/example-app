package com.mycompany.app;

public class Main {
    public static void main(String args[]) {
        if(args.length == 2) {
            var res = Calculator.sum(Integer.parseInt(args[0]), Integer.parseInt(args[1]));
            System.out.println(res);
        }
        else {
            System.err.println("usage: n n");
        }
    }
}
