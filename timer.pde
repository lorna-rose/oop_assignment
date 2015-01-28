class Timer { 
  int savedTime; 
  int totalTime; 

  Timer(int tempTotalTime) { 
    totalTime=tempTotalTime;
  } 

  void start() { 
    savedTime= millis();
  } 

  boolean isFinished() { 
    int passedTime = millis()-savedTime-(lastBlock); 

    if (passedTime > totalTime)
    { 
      return true;
    } else 
    {
      return false;
    }
  }
} 

