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
- `shell.nix` nix expression for dev envrionment
