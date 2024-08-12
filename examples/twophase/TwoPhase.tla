------------------------------- MODULE TwoPhase ----------------------------- 
EXTENDS TLC, Integers, Sequences

VARIABLES t, sentMsgs, deliveredMsgs, payloads, rmState, tmState, tmPrepared

vars == <<t, sentMsgs, deliveredMsgs, payloads, rmState, tmState, tmPrepared>>

clientVars == <<payloads, rmState, tmState, tmPrepared>>
netVars == <<t, sentMsgs, deliveredMsgs>>

RMs == {"rm1", "rm2", "rm3"} 

Net == INSTANCE SynchLib WITH 
    t <- t,
    sentMsgs <- sentMsgs,
    deliveredMsgs <- deliveredMsgs

Sys == INSTANCE Sys WITH
    msgs <- payloads,
    rmState <- rmState,
    tmState <- tmState,
    tmPrepared <- tmPrepared


\* ----- COMPOSED OPERATIONS -----

PrepareMsg == Sys!PrepareMsg /\ UNCHANGED<<netVars>>

SndMsg == UNCHANGED<<clientVars>> /\ \E payload \in payloads: Net!SndMsg(payload)

DeliverMsg == Sys!RcvMsg(msg.payload) /\ \E msg \in sentMsgs: Net!DeliverMsg(msg)

IncTime == UNCHANGED <<clientVars>> /\ Net!IncTime


\* Fault operations

\* CHANGING THESE TO HAVE MINIMAL INTERFACE.
\* This way, easier for tool to automatically iterate thru.
DuplicateMsg == 
    /\ UNCHANGED<<clientVars>> 
    /\ \E msg \in sentMsgs: Net!DuplicateMsg(msg)

\* Since message corruption is domain-specific, we have to use client code.
CorruptMsg == 
    /\ UNCHANGED<<clientVars>> 
    /\ \E msg \in sentMsgs: Net!CorruptMsg(msg, Sys!CorruptMsg)

DropMsg == 
    /\ UNCHANGED<<clientVars>> 
    /\ \E msg \in sentMsgs: Net!DropMsg(msg)

TypeOK == Net!TypeOK

\* ----- Imported safety properties -----

Consistent == Sys!Consistent
AllRcvedSent == Net!AllRcvedSent
AllRcvedInTime == Net!AllRcvedInTime


\* ----- SPECIFICATION -----

Init == Sys!Init /\ Net!Init

Next ==
    \/ PrepareMsg
    \/ SndMsg
    \/ DeliverMsg
    \/ IncTime

\* Faulty nexts

DupNext ==
    \/ Next
    \/ DuplicateMsg

CorruptNext ==
    \/ Next
    \/ CorruptMsg

DropNext ==
    \/ Next
    \/ DropMsg

DropDupNext ==
    \/ DropNext
    \/ DupNext

\* Change the next to try different fault configurations!
Spec == Init /\ [][Next]_vars

=============================================================================
