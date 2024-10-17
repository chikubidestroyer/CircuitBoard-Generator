import java.util.*;
Union invoker;

enum Color {W, B, G};

ArrayList<Union.Node>[] edgeNodes;
ArrayList<Union.Node> startNodes;

void setup(){
  size(600, 600);
  strokeWeight(5);
  
  edgeNodes = new ArrayList[8];
  int modCount = 0;
  for(int i = 0; i < edgeNodes.length; i++){
    edgeNodes[i] = new ArrayList<Union.Node>();
  }
  startNodes = new ArrayList<>();
  
  invoker = new Union();
  for(int i = 0; i < width/10; i++){
    for(int j = 0; j < height/10; j++){
      invoker.board[i][j] = invoker.new Node(i*10, j*10);
    }
  }
  for(int row = 0; row < 60; row += 20){
    for(int col = 0; col < 60; col += 20){
      int modSizeY;
      int modSizeX;
      int modPosX; 
      int modPosY;
      if(row == 20 && col == 20){
        modSizeY = 18;
        modSizeX = 18;
        modPosX = 21;
        modPosY = 21;
        
      }
      else{
        modSizeY = (int)(Math.random()*5+12);
        modSizeX = (int)(Math.random()*5+12);
        modPosX = (int)(Math.random()*(18 - modSizeX)+2)+col;
        modPosY = (int)(Math.random()*(18 - modSizeY)+2)+row;
      }
      
      for(int i = modPosY; i < modPosY+modSizeY; i++){
        for(int j = modPosX; j < modPosX+modSizeX; j++){
          if(i == modPosY || i == modPosY+modSizeY-1 || j == modPosX || j == modPosX+modSizeX-1){ 
            invoker.board[j][i].isEdge = true;
            if(!(row == 20 && col == 20))
              edgeNodes[modCount].add(invoker.board[j][i]);
            else{
              //System.out.println(invoker.board[j][i]);
              startNodes.add(invoker.board[j][i]);
            }
          }
          else invoker.board[j][i] = null;
        }
      }
      if(!(row == 20 && col == 20)) modCount++;
    }
  }
  for(Union.Node[] nodes : invoker.board){
    for(Union.Node n : nodes){
      if(n != null && n.isEdge){
        
        stroke(255, 0, 0);
        //circle(n.x, n.y, 4); 
      }

    }

  }
  background(0);
  stroke(255);
  strokeWeight(1);
  fill(0);
  modCount = 0;
  for(int i = 21; i <= 39; i += 8){
    for(int j = 21; j <= 39; j+= 8){
      
      if(i == 29 && j == 29){j++; continue;}
      Union.Node start = invoker.board[j][i];
      int ran = (int)(Math.random()*edgeNodes[modCount].size());
      //System.out.println(i + " " + j + " mod " + modCount);
      Union.Node n = edgeNodes[modCount].get(ran);
      invoker.setAdjNodes(invoker.board, start, n);
      invoker.BFS(invoker.board, start);
      
      edgeNodes[modCount].remove(n);
      //startNodes.remove(invoker.board[j][i]);
      Union.Node ori = n;
      while(n != start){
        
        if(n.pi == null) break;
        invoker.union(start, n);
        line(n.x, n.y, n.pi.x, n.pi.y);
        n = n.pi;
      }
      if(n == start){ /*circle(n.x, n.y, 6); circle(ori.x, ori.y, 6);*/}
      modCount++;
      
      if(j == 29) j++;
      
    }
    if(i == 29)i++;
  }
  
  int sum = 0;
  for(int i = 0; i < 50; i++){
    sum = invoker.connect();
  }
  int count = 0;
  for(int row = 0; row < invoker.board.length; row++){
    for(int col = 0; col < invoker.board[row].length; col++){
      System.out.println(count++);
      Union.Node n = invoker.board[row][col];
      int tempSum = 0;
      if(n != null && n.head == n && !n.isEdge){
        n.isEdge = true;
        startNodes.add(n);
        for(int i = 0; i < 5; i++){
          tempSum = invoker.connect();
        }
        if(tempSum == sum){
          n.isEdge = false;
          startNodes.remove(n);
        }
        else{sum = tempSum;}
      }
    } 
  }
  
  
  for(int row = 0; row < invoker.board.length; row++){
    for(int col = 0; col < invoker.board[0].length; col++){
      Union.Node n =invoker.board[row][col];
      if(n != null && n.isEdge && n.head != n){
        circle(n.x, n.y, 6);
      }
    }
  }
  for(Union.Node n : startNodes){
     circle(n.x, n.y, 6);
  }
  saveFrame("circuit.png");
}




class Union{
  Node[][] board;
  
  Union(){
    board = new Node[width/10][height/10];
  }
  
  
  int connect(){
    int modCount = 0;
    for(int i = 0 ; i < startNodes.size(); i++){
      Union.Node start = startNodes.get(i);
      int x = (int)start.x/10;
      int y = (int)start.y/10;
      
      if(y < 22){
        if(x < 25 && x > 20) modCount = 0;
        else if(x < 34 && x > 24) modCount = 1;
        else modCount = 2;
      }
      else if(x < 22){
        if(y > 21 && y <26) modCount = 0;
        else if(y > 25 && y < 35) modCount = 3;
        else modCount = 5;
      }
      else if(x > 37){
        if(y > 21 && y < 25) modCount = 2;
        else if(y > 24 && y < 34) modCount = 4;
        else modCount = 7;
      }
      else{
        if(x < 26 && x > 21) modCount = 5;
        else if(x > 25 && x < 35) modCount = 6;
        else modCount = 7;
      }
      //System.out.println(x + " " + y + " mod " + modCount);
      if(edgeNodes[modCount].size()==0) continue;
      int ran = (int)(Math.random()*edgeNodes[modCount].size());
      Union.Node n = edgeNodes[modCount].get(ran);
      
      invoker.setAdjNodes(invoker.board, start, n);
      invoker.BFS(invoker.board, start);
      
      
      //startNodes.remove(start);
      Union.Node ori = n;
      while(n != start){
        
        if(n.pi == null) break;
        invoker.union(start, n);
        line(n.x, n.y, n.pi.x, n.pi.y);
        n = n.pi;
        
      }
      if(n == start){ /*circle(n.x, n.y, 6); circle(ori.x, ori.y, 6); */edgeNodes[modCount].remove(ori);}
      
      
    }
    int sum = 0;
    for(int i = 0; i < edgeNodes.length;i++){
      sum+=edgeNodes[i].size();
    }
    return sum;
  }
  
  
   boolean union(Node con, Node rep){

    if(rep.head != rep){
     
      return false;}
      
    
    rep.head = con.head;
    return true;
   }
  
  class Node{
    boolean isEdge;
    Node head;
    List<Node> adj;
    float x;
    float y;
    Color colour;
    int d;
    Node pi;
    Node(float x, float y){
      adj = new ArrayList<>();
      head = this;
      this.x = x;
      this.y = y;
    }
    String toString(){
      return this.x + " " + this.y;
    }
  }
  
  void setAdjNodes(Node[][] board, Node start, Node end){
    for(int i = 0; i < board.length; i++){
      for(int j = 0; j < board[0].length; j++){
        Node n = board[i][j];
        if(n == null) continue;
        n.adj = new ArrayList<>();
        boolean left = false, right = false, top = false, down = false;
        if(i != 0){
          top = true;
          Node test = board[i-1][j];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test == end)))
            n.adj.add(board[i-1][j]);
        }
        if(i != board.length-1){
          down = true;
          Node test = board[i+1][j];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test == end)))
            n.adj.add(board[i+1][j]);
        }
        if(j != 0){
          left = true;
          Node test = board[i][j-1];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test == end)))
            n.adj.add(board[i][j-1]);
        }
        if(j != board[0].length-1){
          right = true;
          Node test = board[i][j+1];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test == end)))
            n.adj.add(board[i][j+1]);
        }
        if(top && left){
          Node test = board[i-1][j-1];
          if(test != null && (test == test.head) && (!test.isEdge || (test== start || test == end)))
            n.adj.add(board[i-1][j-1]);
        }
        if(top && right){
          Node test = board[i-1][j+1];
          if(test != null && (test == test.head) && (!test.isEdge || (test== start || test == end)))
            n.adj.add(board[i-1][j+1]);
        }
        if(down && left){ 
          Node test = board[i+1][j-1];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test == end)))
            n.adj.add(board[i+1][j-1]);
        }
        if(down && right){
          Node test = board[i+1][j+1];
          if(test != null && (test == test.head) && (!test.isEdge || (test == start || test== end)))
            n.adj.add(board[i+1][j+1]);
        }
      }
    }
  }
  
  void BFS(Node[][] G, Node s){
   
    for(Node[] nodes : G){
      for(Node u : nodes){
        if(u == null) continue;
        if(u != s && u.head == u){
          u.colour = Color.W;
          u.d = Integer.MAX_VALUE;
          u.pi = null;
        }
      }
    }
    s.colour = Color.G;
    s.d = 0;
    s.pi = null;
    ArrayDeque<Node> Q = new ArrayDeque<>();
    Q.offer(s);
    while(!Q.isEmpty()){
      Node u = Q.poll();
      for(Node v : u.adj){
        if(v.colour == Color.W){
          v.colour = Color.G;
          v.d = u.d + 1;
          v.pi = u;
          Q.offer(v);
        }
      }
      u.colour = Color.B;
    }
  }
}
