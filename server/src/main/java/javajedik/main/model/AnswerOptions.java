/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.model;

/**
 *
 * @author kecyke
 */
public class AnswerOptions 
{
    int id;
    String type;
    String answer;

    public AnswerOptions(int id, String type, String answer) 
    {
        this.id = id;
        this.type = type;
        this.answer = answer;
    }

    public AnswerOptions(int id) 
    {
        this.id = id;
    }

    public int getId() 
    {
        return id;
    }

    public String getType() 
    {
        return type;
    }

    public String getAnswer() 
    {
        return answer;
    }
}
