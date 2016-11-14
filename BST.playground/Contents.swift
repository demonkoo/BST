open class TreeNode<T: Comparable> {
    fileprivate var value: T
    fileprivate var parent: TreeNode?
    fileprivate var left: TreeNode?
    fileprivate var right: TreeNode?
    
    public init(value: T,
                parent: TreeNode? = nil,
                left: TreeNode? = nil,
                right: TreeNode? = nil) {
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasSingleLeftChild: Bool {
        return left != nil && right == nil
    }
    
    public var hasSingleRightChild: Bool {
        return left == nil && right != nil
    }
    
    public var hasAnyChild: Bool {
        return left != nil || right != nil
    }
    
    public var hasBothChild: Bool {
        return left != nil && right != nil
    }
}

open class BST<T: Comparable> {
    fileprivate(set) public var root: TreeNode<T>?
    
    public init(_ value: T) {
        self.root = TreeNode<T>(value: value)
    }
    
    public init(_ array: [T]) {
        precondition(array.count > 0)
        
        self.root = TreeNode<T>(value: array[0])
        
        for value in array[1 ..< array.count] {
            insert(value: value)
        }
    }
    
    open func insert(value: T) {
        self.insert(value: value, under: self.root!)
    }
    
    
}

extension BST {
    fileprivate func insert(value: T, under parent: TreeNode<T>) {
        if value < parent.value {
            if let left = parent.left {
                insert(value: value, under: left)
            }
            else {
                let node = TreeNode<T>(value: value)
                parent.left = node
                node.parent = parent
            }
        }
        else if value > parent.value {
            if let right = parent.right {
                insert(value: value, under:right)
            }
            else {
                let node = TreeNode<T>(value: value)
                parent.right = node
                node.parent = parent
            }
        }
    }
    
    fileprivate func printNode(node: TreeNode<T>?) -> String {
        guard node != nil else {
            return ""
        }
        
        var sPrintResult = ""
        
        if !node!.isLeaf && !node!.isRoot {
            sPrintResult += "{"
        }
        
        sPrintResult += printNode(node: node!.left)
        
        let nodeValue = node!.value
        
        if node!.isLeaf {
            sPrintResult += "(\(nodeValue))"
        }
        else if node!.hasSingleLeftChild {
            sPrintResult += " <- [\(nodeValue)]"
        }
        else if node!.hasSingleRightChild {
            sPrintResult += "[\(nodeValue)] -> "
        }
        else if node!.hasBothChild {
            sPrintResult += " <- [\(nodeValue)] -> "
        }
        
        sPrintResult += printNode(node: node!.right)
        
        if !node!.isLeaf && !node!.isRoot {
            sPrintResult += "}"
        }
        
        return sPrintResult
    }
}

extension BST: CustomStringConvertible {
    open var description: String {
        return self.printNode(node: self.root)
    }
}

let tree = BST<Int>(10)
let tree1 = BST<Int>([6, 4, 7, 3, 5, 8])
let tree2 = BST<Int>([4, 7, 6, 3, 5, 8])

print(tree1)
print(tree2)
