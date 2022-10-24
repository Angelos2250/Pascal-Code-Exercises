UNIT ModTreeA2;

INTERFACE
  TYPE
    NodePtr = ^Node;
    Node = RECORD
      left, right: NodePtr;
      val: STRING;
    END; (* Node *)
    TreePtr = NodePtr;
    
  PROCEDURE DisposeTree(VAR t: TreePtr);
  FUNCTION NewNode(value: STRING): NodePtr;
  FUNCTION TreeOf(root: NodePtr; left, right: NodePtr): NodePtr;
  PROCEDURE PrintInOrder(t: TreePtr);
  PROCEDURE PrintPostOrder(t: TreePtr);
  PROCEDURE PrintPreOrder(t: TreePtr);
  FUNCTION ValueOf(t: TreePtr): INTEGER;

IMPLEMENTATION

  PROCEDURE DisposeTree(VAR t: TreePtr);
  BEGIN (* DisposeTree *)
    IF (t <> NIL) THEN BEGIN
      DisposeTree(t^.left);
      DisposeTree(t^.right);
      Dispose(t);
      t := NIL;
    END; (* IF *)
  END; (* DisposeTree *)

  FUNCTION NewNode(value: STRING): NodePtr;
    VAR 
      n: NodePtr;
  BEGIN (* NewNode *)
    New(n);
    n^.val := value;
    n^.left := NIL;
    n^.right := NIL;
    NewNode := n;
  END; (* NewNode *)

  FUNCTION TreeOf(root: NodePtr; left, right: NodePtr): NodePtr;
  BEGIN (* TreeOf *)
    root^.left := left;
    root^.right := right;
    TreeOf := root;
  END; (* TreeOf *)

  PROCEDURE PrintInOrder(t: TreePtr);
  BEGIN (* PrintInOrder *)
    IF (t <> NIL) THEN BEGIN
      PrintInOrder(t^.left);
      Write(t^.val:4);
      PrintInOrder(t^.right);
    END; (* IF *)
  END; (* PrintInOrder *)

  PROCEDURE PrintPostOrder(t: TreePtr);
  BEGIN (* PrintPostOrder *)
    IF (t <> NIL) THEN BEGIN
      PrintPostOrder(t^.left);
      PrintPostOrder(t^.right);
      Write(t^.val:4);
    END; (* IF *)
  END; (* PrintPostOrder *)

  PROCEDURE PrintPreOrder(t: TreePtr);
  BEGIN (* PrintPreOrder *)
    IF (t <> NIL) THEN BEGIN
      Write(t^.val:4);
      PrintPreOrder(t^.left);
      PrintPreOrder(t^.right);
    END; (* IF *)
  END; (* PrintPreOrder *)

  FUNCTION ValueOf(t: TreePtr): INTEGER;
    VAR
      number,i: INTEGER;
  BEGIN (* ValueOf *)
    IF (t^.val = '*') THEN BEGIN
      ValueOf := ValueOf(t^.left) * ValueOf(t^.right);
    END ELSE IF (t^.val = '+') THEN BEGIN
      ValueOf := ValueOf(t^.left) + ValueOf(t^.right);
    END ELSE IF (t^.val = '-') THEN BEGIN 
      ValueOf := ValueOf(t^.left) - ValueOf(t^.right);
    END ELSE IF (t^.val = '/') THEN BEGIN
      ValueOf := ValueOf(t^.left) DIV ValueOf(t^.right);
    END ELSE BEGIN
      FOR i := 1 TO Length(t^.val) DO BEGIN
        number := 0;
        number := (number * 10) + Ord(t^.val[i]) - Ord('0'); 
        ValueOf := number;
      END; (* FOR *)
    END;
  END; (* ValueOf *)

BEGIN (* ModTreeA2 *)
  
END. (* ModTreeA2 *)