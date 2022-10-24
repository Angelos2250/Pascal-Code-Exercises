UNIT ModTree;

INTERFACE
  TYPE
    NodePtr = ^Node;
    Node = RECORD
      firstChild, sibling: NodePtr;
      val: STRING;
    END; (* Node *)
    TreePtr = NodePtr;

  FUNCTION InitTree: TreePtr;
  PROCEDURE DisposeTree(VAR t: TreePtr);
  FUNCTION NewNode(value: STRING): NodePtr;
  FUNCTION TreeOf(root: NodePtr; left, right: NodePtr): NodePtr;
  PROCEDURE PrintTree(t: TreePtr);
  PROCEDURE AppendSibling(VAR n: NodePtr; s1, s2: NodePtr);

IMPLEMENTATION

  FUNCTION InitTree: TreePtr;
    VAR t: TreePtr;
  BEGIN (* InitTree *)
    t := NIL;
    InitTree := t;
  END; (* InitTree *)

  PROCEDURE DisposeTree(VAR t: TreePtr);
  BEGIN (* DisposeTree *)
    IF (t <> NIL) THEN BEGIN
      DisposeTree(t^.firstChild);
      DisposeTree(t^.sibling);
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
    n^.firstChild := NIL;
    n^.sibling := NIL;
    NewNode := n;
  END; (* NewNode *)

  FUNCTION TreeOf(root: NodePtr; left, right: NodePtr): NodePtr;
  BEGIN (* TreeOf *)
    root^.firstChild := left;
    root^.sibling := right;
    TreeOf := root;
  END; (* TreeOf *)
  
  PROCEDURE PrintTree(t: TreePtr);
  BEGIN (* PrintTree *)
    IF (t <> NIL) THEN BEGIN
      PrintTree(t^.sibling);
      WriteLn(t^.val);
      PrintTree(t^.firstChild);
    END; (* IF *)
  END; (* PrintTree *)

  PROCEDURE AppendSibling(VAR n: NodePtr; s1, s2: NodePtr);
    VAR
      lastSibling: NodePtr;
  BEGIN (* AppendSibling *)
    lastSibling := n;
    WHILE (lastSibling^.sibling <> NIL) DO BEGIN
      lastSibling := lastSibling^.sibling;
    END; (* WHILE *)
    lastSibling^.sibling := s1;
    s1^.sibling := s2;
  END; (* AppendSibling *)

BEGIN (* ModTree *)
  
END. (* ModTree *)