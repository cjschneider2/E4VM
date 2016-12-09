-define(SIGNATURE, <<"3EAM">>).
-define(SIG_EXPORTS, <<"ExpT">>).
-define(SIG_ATOMS, <<"Atom">>).
-define(SIG_CODE, <<"Code">>).

-define(MARK_FUNCTION, <<255:8>>).
-define(MARK_END_CODE, <<254:8>>).

-define(VAL_NIL,        0).
-define(VAL_X,          1).
-define(VAL_Y,          2).
-define(VAL_ATOM,       3).
-define(VAL_MFARITY,    4).
-define(VAL_INTEGER,    5).
-define(VAL_LIT,        6).
-define(VAL_Z,          7). % internal Z register, 4 upper bits are register id

-define(OPCODE_MOVE,         1). % move(Src, Dst)
-define(OPCODE_CALL,         2). % call(Arity) Z0=CodePtr
-define(OPCODE_TAIL_CALL,    3). % tail_call(Arity) Z0=CodePtr
-define(OPCODE_CONS,         4).
-define(OPCODE_DECONS,       5). % deconstructs list
-define(OPCODE_RET,          6).
-define(OPCODE_TEST1,        7). % checks jumps to fail, arity 1
-define(OPCODE_TEST2,        8). % checks jumps to fail, arity 2
-define(OPCODE_TUPLE_APPEND, 9). % appends to last put_tuple
-define(OPCODE_JUMP,         10). % jumps to Label
-define(OPCODE_SELECT_VAL,   11). % select(Val, OnFail, Choices)
-define(OPCODE_ELEMENT,      12). % get tuple element(Src E Dst)
-define(OPCODE_ALLOC,        13). % grows a new stack frame
-define(OPCODE_DEALLOC,        14). % removes a stack frame
-define(OPCODE_RESOLVE_EXPORT, 15). % figures out code location
-define(OPCODE_TEST_HEAP,      16). % checks heap/stack size
-define(OPCODE_ERROR,          17). % produces error({Arg1,Arg2=NONVALUE}