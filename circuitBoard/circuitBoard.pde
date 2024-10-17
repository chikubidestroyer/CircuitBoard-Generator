import java.util.*;
Union invoker;
enum SlantDirection{LS, RS, ST, LST, RST} // LeftSlant, RightSlant, Straight, LeftStraight, RightStraight
enum GeneralDirection{
  Up{
    Tuple DecideDirection(Union.Node n, SlantDirection s, Union invoker){
      int x = (int)n.x/10;
      int y = (int)n.y/10;
      int result = (int)(Math.random()*3);
      boolean l = invoker.board[x-1][y].head == invoker.board[x][y-1].head;
      boolean r = invoker.board[x+1][y].head == invoker.board[x][y-1].head;
      switch(s){
        case LS:
          if(invoker.board[x-1][y].head != invoker.board[x-1][y] 
            && invoker.board[x-1][y-1].head != invoker.board[x-1][y-1] 
            && invoker.board[x][y-1].head != invoker.board[x][y-1]) return null;
          if(l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][y], lst);
            case 1 : return new Tuple(invoker.board[--x][--y], ls);
            case 2 : return new Tuple(invoker.board[x][--y], st);
          }
          break;
        case RS:
          if(invoker.board[x+1][y].head != invoker.board[x+1][y] 
            && invoker.board[x+1][y-1].head != invoker.board[x+1][y-1] 
            && invoker.board[x][y-1].head != invoker.board[x][y-1]) return null;
          if(r) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][y], rst);
            case 1 : return new Tuple(invoker.board[++x][--y], rs);
            case 2 : return new Tuple(invoker.board[x][--y], st);
          }
          break;
        case ST:
          if(invoker.board[x-1][y-1].head != invoker.board[x-1][y-1] 
            && invoker.board[x+1][y-1].head != invoker.board[x+1][y-1] 
            && invoker.board[x][y-1].head != invoker.board[x][y-1]) return null;
          if(l && r) return null;
          if(l && invoker.board[x+1][y-1].head != invoker.board[x+1][y-1]) return null;
          if(r && invoker.board[x-1][y-1].head != invoker.board[x-1][y-1]) return null;

          switch(result){
            case 0 : return new Tuple(invoker.board[++x][--y], rs);
            case 1 : return new Tuple(invoker.board[--x][--y], ls);
            case 2 : return new Tuple(invoker.board[x][--y], st);
          }
        case LST:
          if(invoker.board[x-1][y].head != invoker.board[x-1][y] 
            && invoker.board[x-1][y-1].head != invoker.board[x-1][y-1]) return null;
          if(l) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][y], lst);
            case 1 : return new Tuple(invoker.board[--x][--y], ls); 
          }
        case RST:
          if(invoker.board[x+1][y].head != invoker.board[x+1][y] 
            && invoker.board[x+1][y-1].head != invoker.board[x+1][y-1]) return null;
          if(r) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][y], rst);
            case 1 : return new Tuple(invoker.board[++x][--y], rs); 
          }
      }
      return null;
    }
  }, 
  Down{
    Tuple DecideDirection(Union.Node n, SlantDirection s, Union invoker){
      int x = (int)n.x/10;
      int y = (int)n.y/10;
      int result = (int)(Math.random()*3);
      boolean l = invoker.board[x+1][y].head == invoker.board[x][y+1].head;
      boolean r = invoker.board[x-1][y].head == invoker.board[x][y+1].head;
      switch(s){
        case RS:
          if(invoker.board[x-1][y].head != invoker.board[x-1][y] 
            && invoker.board[x-1][y+1].head != invoker.board[x-1][y+1] 
            && invoker.board[x][y+1].head != invoker.board[x][y+1]) return null;
          if(r) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][y], rst);
            case 1 : return new Tuple(invoker.board[--x][++y], rs);
            case 2 : return new Tuple(invoker.board[x][++y], st);
          }
          break;
        case LS:
          if(invoker.board[x+1][y].head != invoker.board[x+1][y] 
            && invoker.board[x+1][y+1].head != invoker.board[x+1][y+1] 
            && invoker.board[x][y+1].head != invoker.board[x][y+1]) return null;
          if(l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][y], lst);
            case 1 : return new Tuple(invoker.board[++x][++y], ls);
            case 2 : return new Tuple(invoker.board[x][++y], st);
          }
          break;
        case ST:
          if(invoker.board[x+1][y+1].head != invoker.board[x+1][y+1] 
            && invoker.board[x-1][y+1].head != invoker.board[x-1][y+1] 
            && invoker.board[x][y+1].head != invoker.board[x][y+1]) return null;
          if(r && l) return null;
          if(l && invoker.board[x-1][y+1].head != invoker.board[x-1][y+1]) return null;
          if(r && invoker.board[x+1][y+1].head != invoker.board[x+1][y+1]) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][++y], ls);
            case 1 : return new Tuple(invoker.board[--x][++y], rs);
            case 2 : return new Tuple(invoker.board[x][++y], st);
          }
        case LST:
          if(invoker.board[x+1][y].head != invoker.board[x+1][y] 
            && invoker.board[x+1][y+1].head != invoker.board[x+1][y+1]) return null;
          if(l) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][y], lst);
            case 1 : return new Tuple(invoker.board[++x][++y], ls); 
          }
        case RST:
          if(invoker.board[x-1][y].head != invoker.board[x-1][y] 
            && invoker.board[x-1][y+1].head != invoker.board[x-1][y+1]) return null;
          if(r) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][y], rst);
            case 1 : return new Tuple(invoker.board[--x][++y], rs); 
          }
      }
      return null;
    }
  }, Left{
    Tuple DecideDirection(Union.Node n, SlantDirection s, Union invoker){
      int x = (int)n.x/10;
      int y = (int)n.y/10;
      int result = (int)(Math.random()*3);
      boolean l = invoker.board[x][y+1].head == invoker.board[x-1][y].head;
      boolean r = invoker.board[x][y-1].head == invoker.board[x-1][y].head;
      switch(s){
        case LS:
          if(l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][++y], ls);
            case 1 : return new Tuple(invoker.board[x][++y], lst);
            case 2 : return new Tuple(invoker.board[--x][y], st);
          }
          break;
        case RS:
          if(r) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[x][--y], rst);
            case 1 : return new Tuple(invoker.board[--x][--y], rs);
            case 2 : return new Tuple(invoker.board[--x][y], st);
          }
          break;
        case ST:
          if(r && l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[--x][++y], ls);
            case 1 : return new Tuple(invoker.board[--x][--y], rs);
            case 2 : return new Tuple(invoker.board[--x][y], st);
          }
        case LST:
          if(l) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[x][++y], lst);
            case 1 : return new Tuple(invoker.board[--x][++y], ls); 
          }
        case RST:
          if(r) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[x][--y], rst);
            case 1 : return new Tuple(invoker.board[--x][--y], rs); 
          }
      }
      return null;
    }
  }, 
  Right{
    Tuple DecideDirection(Union.Node n, SlantDirection s, Union invoker){
      int x = (int)n.x/10;
      int y = (int)n.y/10;
      int result = (int)(Math.random()*3);
      boolean l = invoker.board[x][y-1].head == invoker.board[x+1][y].head;
      boolean r = invoker.board[x][y+1].head == invoker.board[x+1][y].head;
      switch(s){
        case LS:
          if(l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[x][--y], lst);
            case 1 : return new Tuple(invoker.board[++x][--y], ls);
            case 2 : return new Tuple(invoker.board[++x][y], st);
          }
          break;
        case RS:
          if(r) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[x][++y], rst);
            case 1 : return new Tuple(invoker.board[++x][++y], rs);
            case 2 : return new Tuple(invoker.board[++x][y], st);
          }
          break;
        case ST:
          if(r && l) return null;
          switch(result){
            case 0 : return new Tuple(invoker.board[++x][--y], ls);
            case 1 : return new Tuple(invoker.board[++x][++y], rs);
            case 2 : return new Tuple(invoker.board[++x][y], st);
          }
        case LST:
          if(l) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[x][--y], lst);
            case 1 : return new Tuple(invoker.board[++x][--y], ls); 
          }
        case RST:
          if(r) return null;
          result = (int)(Math.random()*2);
          switch(result){
            case 0 : return new Tuple(invoker.board[x][++y], rst);
            case 1 : return new Tuple(invoker.board[++x][++y], rs); 
          }
      }
      return null;
    }
  };
  
  static SlantDirection ls = SlantDirection.LS;
  static SlantDirection rs = SlantDirection.RS;
  static SlantDirection lst = SlantDirection.LST;
  static SlantDirection rst = SlantDirection.RST;
  static SlantDirection st = SlantDirection.ST;
  
  abstract Tuple DecideDirection(Union.Node n, SlantDirection s, Union invoker);
}

List<Union.Node> nodes;

void setup(){
  size(500, 500);
  strokeWeight(5);
  nodes = new ArrayList<>();
  invoker = new Union();
  for(int i = 0; i < width/10; i++){
    for(int j = 0; j < height/10; j++){
      invoker.board[i][j] = invoker.new Node(i*10, j*10);
    }
  }
  
  int x = width/20;
  int y = height/30;
  for(int i = 15; i < 35; i+=2){
    Union.Node start1 = invoker.board[i][y];
    nodes.add(start1);
    invoker.unionize(start1, GeneralDirection.Up);
    Union.Node start2 = invoker.board[i][50-y];
    nodes.add(start2);
    invoker.unionize(start2, GeneralDirection.Down);
  }
  
  /*Union.Node start = invoker.board[x][y];
  nodes.add(start);
  invoker.unionize(start, GeneralDirection.Up);
  start = invoker.board[x+1][y];
  invoker.unionize(start, GeneralDirection.Up);
  nodes.add(start);
  start = invoker.board[x+2][y];
  invoker.unionize(start, GeneralDirection.Up);
  nodes.add(start);*/

  
  
  //invoker.iterateNext(start);
  for(Union.Node n : nodes){
    invoker.iterateNext(n);
  }
}



void draw(){
  
}

static class Tuple{
  Union.Node n;
  SlantDirection sd;
  Tuple(Union.Node n, SlantDirection sd){
    this.n = n;
    this.sd = sd;
  }
}

class Union{
  Node[][] board;
  Union(){
    board = new Node[width/10][height/10];
  }
  
  
  
  class Node{
    Node head;
    Node previous;
    List<Node> next;
    SlantDirection dir;
    float x;
    float y;
    boolean tail;
    Node(float x, float y){
      dir = null;
      head = this;
      previous = null;
      this.x = x;
      this.y = y;
      tail = false;
      next = new ArrayList();
    }
    String toString(){
      return this.x + " " + this.y;
    }
  }
  boolean union(Node con, Node rep){
    System.out.println(con + " " + rep);
    if(rep.head != rep){
      System.out.println(rep + " " + rep.head);
      return false;}
      
    // Testing whether if adj nodes are in union, prevents crossing
    int xDiff = (int)(rep.x/10 - con.x/10);
    int yDiff = (int)(rep.y/10 - con.y/10);
    Node adj1 = invoker.board[(int)con.x/10][(int)con.y/10+yDiff];
    Node adj2 = invoker.board[(int)con.x/10+xDiff][(int)con.y/10];
    if(adj1.head == adj2.head)
      return false;
    
    rep.head = con.head;
    con.tail = false;
    rep.tail = true;
    rep.previous = con;
    con.next.add(rep);
    return true;
  }
  void iterateNext(Union.Node start){
    System.out.println(start.next);
    for(Union.Node n : start.next){
      line(start.x, start.y, n.x, n.y);
      
      iterateNext(n);
      
    }
  }
  
  void unionize(Node start, GeneralDirection dir){
    int x = (int)start.x/10;
    int y = (int)start.y/10;
    switch(dir){
      case Up : union(start, invoker.board[x][y-1]); y--; break;
      case Down : union(start, invoker.board[x][y+1]); y++; break;
      case Left : union(start, invoker.board[x-1][y]); x--; break;
      case Right : union(start, invoker.board[x+1][y]); x++; break;
    }
    SlantDirection sl = SlantDirection.ST;
    
    Outer : while(x < invoker.board.length-1 && x >1 && y < invoker.board.length-1 && y>1){
      Node n = invoker.board[x][y];
      //System.out.println(n.x + " " + n.y);
      boolean touch = true;
      
      while(touch){
        System.out.println(sl + " " + n.x + " " + n.y);
        Tuple tuple = dir.DecideDirection(n, sl, invoker);
        if(tuple == null){ System.out.println("nogood");break Outer;}
        Node temp = tuple.n;
        
        if(invoker.union(n, temp)){
          touch = false;
          sl = tuple.sd;
          x = (int)(temp.x/10); y = (int)(temp.y/10);
        }

      }
    }
  }
}
