 using UnityEngine;
 using UnityEngine.UI;
 using System.Collections;
 
 public class CountDown : MonoBehaviour
 {
     float timeLeft = 60.0f;
     public Text text;
     
     void Update()
     {
         timeLeft -= Time.deltaTime;
         text.text = "Time Left:" + Mathf.Round(timeLeft);
         if(timeLeft < 0)
         {
             Application.LoadLevel("gameOver");
         }
     }
 }
