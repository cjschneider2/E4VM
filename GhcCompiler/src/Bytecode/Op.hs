module Bytecode.Op
  ( Opcode(..)
  , Instruction(..)
  ) where

import qualified Bytecode.Bits as BB
import           Uerlc

import qualified Data.List     as L
import           Data.Maybe    (fromJust)
import           Data.Tuple

data Opcode
  = Alloc
  | BsContextToBin
  | Call
  | CallBif
  | CallBifGc
  | CallFun
  | CallGc
  | CallTail
  | CallTailDealloc
  | Cons
  | Decons
  | Error
  | Jump
  | MakeFun
  | Move
  | Ret0
  | RetN
  | SelectTupleArity
  | SelectVal
  | SetNil
  | Test
  | TestHeap
  | Trim
  | TupleGetEl
  | TupleNew
  | TuplePut
  | TupleSetEl
  deriving (Eq, Ord)

instance Show Opcode where
  show Alloc            = "+alloc"
  show BsContextToBin   = "+bs/ctx2bin"
  show CallBif          = "+bif"
  show CallBifGc        = "+bif/gc"
  show CallFun          = "+callf"
  show CallGc           = "+call/gc"
  show Call             = "+call"
  show CallTail         = "+call/tail"
  show CallTailDealloc  = "+call/tail/dealloc"
  show Cons             = "+cons"
  show Decons           = "+decons"
  show Error            = "+err"
  show Jump             = "+jmp"
  show MakeFun          = "+makefun"
  show Move             = "+move"
  show Ret0             = "+ret0"
  show RetN             = "+retn"
  show SelectTupleArity = "+selarity"
  show SelectVal        = "+selval"
  show SetNil           = "+nil"
  show Test             = "+test"
  show TestHeap         = "+testheap"
  show Trim             = "+trim"
  show TupleGetEl       = "+t_get"
  show TupleNew         = "+t_new"
  show TuplePut         = "+t_put"
  show TupleSetEl       = "+t_set"

bcOpEnumTable :: [(Opcode, Int)]
bcOpEnumTable =
  [ (Error, 0)
  , (Test, 1)
  , (Alloc, 2)
  , (Move, 3)
  , (TestHeap, 4)
  , (Jump, 5)
  , (SetNil, 6)
  , (Trim, 7)
  , (MakeFun, 8)
  -- ---------
  , (Call, 10)
  , (CallGc, 11)
  , (CallTail, 12)
  , (CallTailDealloc, 13)
  , (CallFun, 14)
  , (CallBif, 15)
  , (CallBifGc, 16)
  , (Ret0, 17)
  , (RetN, 18)
  -- ---------
  , (TupleNew, 20)
  , (TuplePut, 21)
  , (TupleGetEl, 22)
  , (TupleSetEl, 23)
  -- ---------
  , (Decons, 30)
  , (Cons, 31)
  -- ---------
  , (SelectVal, 40)
  , (SelectTupleArity, 41)
  -- ---------
  , (BsContextToBin, 50)
  ]

instance Enum Opcode where
  fromEnum = fromJust . flip L.lookup bcOpEnumTable
  toEnum = fromJust . flip lookup (map swap bcOpEnumTable)

-- A combination of {Opcode and [Bit Encoded Args]}
data Instruction =
  Instruction Opcode
              BB.BitsList

instance Show Instruction where
  show (Instruction op bits) = show (fromEnum op) ++ " " ++ show bits ++ comment
    where
      comment = ansiCyan ++ " ; " ++ show op ++ ansiReset
