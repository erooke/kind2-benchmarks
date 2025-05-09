# Kondo-lustre

Lustre implementations of proofs from [Inductive Invariants That Spark Joy:
Using Invariant Taxonomies to Streamline Distributed Protocol
Proofs](https://www.usenix.org/conference/osdi24/presentation/zhang-nuda).

## Files

### Models
- `common.lus` Commonly used types across all models
- `client-server.lus` Model of the client-server protocol
- `distributed-lock.lus` Model of the distributed-lock protocol
- `leader-election.lus` Daniels model of ring leaders
- `ring-leader.lus` Ethan's failed attempt at modeling ring leaders

### Misc

- `nix` nix expressions for pinning inputs + building kind2
- `shell.nix` nix expression for dev environment

# Model Descriptions

What follows are brief, high level, English descriptions, of what the models
are aiming to encode.

## Distributed lock

Models a distributed resource that at most one node is allowed to work on at a
time. When a node is done working with the resource it sends a message to
another node relinquishing the lock. The safety property we guarantee is:

> At all times at most one node believes it has access to the lock

### Network semantics

The network for this model encodes at most once delivery. Messages are held in
a set until they are received, once received they are removed from the set.

### Nodes

On each time step the node does the following:

1. If the node has the lock it may choose to send a message relinquishing the
   lock
2. If the node does not have the lock but received a message granting it the
   lock it acquires the lock
3. If the node does not have the lock and is not receiving a message it does nothing

## Client Server

This models a network where nodes may make requests of other nodes. The safety
property which is guaranteed is:

> Every response that a node gets is in reply to a request it made

### Network semantics

The network here only guarantees that a message which is received by a node
was, at some point, sent by a node. There is no guarantee that a message is
delivered nor how many times.

### Nodes

On each time step nodes do the following:

1. If they have received a request they immediately publish a response
2. If they are waiting on a response but have not received it they do nothing
3. If they are waiting on a response and have received it they mark themselves
   as no longer waiting
4. Otherwise they may send a request to a random node

## Leader Election

This models a ring of nodes which is attempting to elect a leader. Each node
may only send messages to its neighbor. Each node has a unique, ordered, id.
The protocol is a distributed maxima finding algorithm. The safety property
which is guaranteed is:

> At any point in time there is at most one leader

### Network Semantics

The network here only guarantees that a message which is received by a node
was, at some point, sent by a node. There is no guarantee that a message is
delivered nor how many times.

### Nodes

Nodes here keep track of the largest id they have heard. On each time step
nodes do the following:

1. If they receive a message they update the record of the largest id they have
   heard
2. They send a message to their neighbor of the largest id they have heard
