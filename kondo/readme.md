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
