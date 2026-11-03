---
name: documentation-style
description: "Use in any response that wrote or edited a doc comment, an inline comment or a system doc in this crate, before that response ends, to rewrite that text against the crate's documentation rules. Triggers: wrote a comment, wrote a doc comment, updated a system doc, changed documentation, refine the comments, documentation pass, rewrite these comments."
version: 1.0.0
---

# Documentation Style

The rules for every doc comment, inline comment and system doc in this crate.

## Running the pass

Write new text to these rules as the change is written, then read every line that the change
touched a second time. The writing pass and the refinement pass catch different faults, so a
line written to the rules still gets read again. The refinement pass checks every rule below.

In every example pair, the first line breaks the rule and the second line follows it.

Read the code that a comment describes before rewriting the comment. A rewrite must never
invent a reason that the code does not show.

## Terminology

**Give a concept one term and use that term everywhere the concept appears.** The reader learns
one term per concept, and must never map a second term onto the same concept.

**Do not substitute a synonym.** Plain English offers other words for most concepts, and those
words are still wrong where the crate has an established term. One term per concept, for verbs
and nouns alike, leaves only a few correct ways to write a sentence.

**Tell the reader when a change introduces a term that appears nowhere else.** A new term widens
the conceptual space, and the reader pays that cost at every later mention.

**Do not give one term two meanings in a sentence.** Reword the sentence, or name one meaning as
the Rust item:

```rust
// set the leaves covered by a filled gridtree node to filled
// set the leaves covered by a filled gridtree node to `Leaf::Filled`
```

**Search the crate for a word before treating that word as the established term.** Every
terminology rule turns on which words the crate already uses, and one search of the crate gives
the answer. Only search .rs files, system docs are not for terminology reference.

## Inline comments

**Write an action in an imperative mood.** Where the code acts, the comment reads as an
instruction rather than as a statement about the code:

```rust
// a removed BLAS must not stay queued for a build that can no longer happen
// drop a removed BLAS from a build that can never happen
```

**Name the operation with the verb the crate uses for that operation.** A verb from outside the
crate's vocabulary names no operation, and a verb the crate keeps for another operation names
the wrong one:

```rust
// give the leaves covered by a filled gridtree node a `Leaf::Filled`
// set the leaves covered by a filled gridtree node to `Leaf::Filled`
```

```rust
// the gridtree arenas holding every strip this BLAS allocated
// the gridtree arenas containing every strip this BLAS allocated
```

**Name a state with a noun phrase.** Where a comment labels data rather than an action, write the
noun phrase:

```rust
// compacted data used in the intersection shader
```

Comments above buffer creation sites take the same form.

**Give a reason only where the reader can check the reason.** A reason joined with `so` has to
name something concrete:

```rust
// drop outdated BLAS ids so the rest of the pass can index every id that remains
// drop outdated BLAS ids so the rest of the pass can index allocations directly
```

**Do not use a colon.** A colon belongs before a list, and never inside a sentence.

**Write comments in lowercase**, apart from `SAFETY` and `TODO`.

**Comment only where the code needs explaining.**

## Doc comments

**Open with one sentence that says what the item does or returns.** Constraints, mechanism and
edge cases follow that sentence.

**Name the parameters that the summary depends on, spelled as the signature spells them**, in
backticks.

**Say what an absent result means.** `or None if those coordinates are outside the grid extent`.

**Say what the signature does not.** The signature already gives the item name and the return
type.

**Name the type a constructor returns, in [`brackets`].** A `new` opens with `Constructs a new
[`Type`]`, and the rest of the sentence gives what the arguments set.

**Write docs in third person, in the simple present.** The simple present states what an item
does, so a doc never reads `will return` or `returned`. A clause that puts one event before
another takes the tense that sequence needs, as in `once every child has been generated`.

**Spell Rust items as the code spells them**, in backticks, or in [`brackets`] where a link to
the item helps the reader. This covers types, variants, functions and fields, so `None` rather
than none.

**Write for a reader who has never seen the change.** Never justify a decision against the
alternative that the change replaced, and never compare to another part of the crate that the
reader may not know. Write every doc as though the code was correct on the first attempt.

### Example docs

```rust
/// Constructs a new [`GridtreeGrid`] for storing gridtree data inside cells of a given
/// `cell_size`.
///
/// The extent of the gridtree grid is sized automatically to encompass the total
/// `world_size` with gridtree cells, with each component of the extent limited by the
/// corresponding value in `max_size`.
pub fn new(
    cell_size: usize,
    world_size: u32,
    max_size: UVec3,
) -> Self { ... }

/// Returns a reference to the gridtree node at the given `pos` and `depth` by traversing
/// the node hierarchy of the gridtree cell that contains `pos`, or `None` if `pos` lies
/// outside the grid extent.
pub fn node(&self, pos: UVec3, depth: u8) -> Option<&GridtreeNode> { ... }
```

## System docs

**Keep a system doc under 50 lines** unless the system needs more.

**Leave code samples out** unless a sample is the only way to explain the system.

**Update the doc for a system in the same change that alters how the system behaves.**

## Sentence structure

**Write so that no word changes the role of a word before it.** The reader must never re-read a
sentence to reassign its parts.

**Keep a verb beside its object, and a subject beside its verb.** Move everything else to the
right of the clause.

**Modify a noun with a phrase that starts with its verb.** Never place a subject between a noun
and the verb that acts on that noun. Write the verb as a participle, as in `covered by`, or start
the clause with `that` followed directly by its verb:

```rust
// set the leaves a filled gridtree node covers to `Leaf::Filled`
// set the leaves covered by a filled gridtree node to `Leaf::Filled`
```

**Start a modifier with a word that marks the phrase as a modifier**, such as `covered by`,
`for`, `that`, `while` or `so`.

**Keep the subject, verb and article explicit.** A dropped word leaves the reader to guess which
noun a sentence is about.

**Chain phrases rather than nest them.** A long sentence reads well where every phrase attaches
to the phrase before it.

**Fold a reason into the action.** A clause that starts with `since`, `as`, or `because`. gives a
reason that the action can usually carry itself. Fold the reason into the object of the action,
into a purpose that starts with `to`, or into a more exact verb:

```rust
// skip a node without generated data, since it has nothing to build
// skip a node with no generated data to build from
```

```rust
// count the texels of every strip, since the count sizes the upload buffer
// count the texels of every strip to size the upload buffer
```

A fold changes the action itself. Replacing `since` with a comma and a trailing phrase leaves
the reason appended to the thought, and is no fold. Keep a reason clause only when no fold keeps
the meaning.

**Do not append a clause with `, which`.** A comma lets `which` attach to the nearest noun or to
the whole preceding clause, so the reader searches backwards for the antecedent. Give the fact
its own sentence, or name the term that the clause describes.

**Never use a semicolon or an em dash.** A semicolon or an em dash joins what belongs in
separate sentences. Prefer English words to special characters.

## Word choice

**Name the operation rather than an action a person takes.** Anthropomorphic verbs such as `hand`,
`find`, `see`, `know`, `want`, `ask`, or `decide` describe a person, and only stand in for the
operation the code performs. Name that operation, or the order the operations run in, with the term
the crate uses:

```rust
// hand a zero sized allocation a dangling pointer
// return a dangling pointer for a zero sized layout
```

**Repeat the term instead of using a pronoun.**

**Write the verb rather than the noun made from the verb.** A noun made from an action reads
longer and hides the actor.

**Prefer one exact word to a combination of words with a second reading.** The reader discards
the second reading before arriving at the meaning:

```rust
/// Returns the node at `pos` by going through the node hierarchy of the cell.
/// Returns the node at `pos` by traversing the node hierarchy of the cell.
```

**Keep a noun phrase to three words.** A longer stack leaves the reader to work out which noun
modifies which.

**Keep every hedge at the strength of the original.** A hedge carries the confidence of the
author, and confidence is content. `may have failed` never becomes `failed`.

**Delete a word that claims quality in place of a measurement**, such as seamless, robust,
powerful or effortless.

**Write `stores` or `contains` rather than `holds` or `keeps`.** A buffer, a field or a pointer
`stores` a value, and a volume or a collection `contains` what is inside it. `holds` and `keeps`
describe retaining something over time rather than where it is, so neither they nor any similarly
loose verb should replace an established one.

## Refinement pass

Read every comment and doc that the change touched, and check every line for each fault below.
Each fault sits under the same section as the rules it breaks, and describes the words that
break those rules, so every check points at text on the page. Fix a fault with the rules from
that section.

### Terminology

1. **Synonym rotation.** One concept carries several names, or a word stands where the crate
   uses another term for the same noun or verb.
1. **Unannounced terms.** A word that no .rs file uses names a concept, and the change does not
   tell the reader about the new term.
1. **Double meanings.** One word carries two meanings in the same sentence.

### Inline comments

1. **Statements of action.** A comment above code that acts describes the code rather than
   giving an instruction.
1. **Sentences for state.** A comment labelling data is a full sentence rather than a noun
   phrase.
1. **Unchecked reasons.** A reason after `so` or `since` names nothing the reader can find in
   the code.
1. **Inline colons.** A colon sits inside a sentence of an inline comment.
1. **Capitals.** An inline comment starts with a capital letter, apart from `SAFETY` and `TODO`.
1. **Redundant comments.** A comment restates what the code beside the comment already says.

### Doc comments

1. **Weak openings.** The first sentence does not say what the item does or returns.
1. **Unnamed parameters.** The summary depends on a parameter without naming that parameter in
   backticks.
1. **Silent absent results.** An item that can return `None` or nothing does not say what that
   result means.
1. **Restated signatures.** The doc says only what the name and the signature already say.
1. **Unnamed constructors.** A `new` does not open with `Constructs a new [`Type`]`.
1. **Wrong person or tense.** A doc uses `we`, `you`, `will`, or a past tense for what the item
   does.
1. **Plain item names.** A type, variant, function or field appears as a plain word rather than
   in backticks.
1. **Change history.** A doc compares the code to an earlier version, to an alternative, or to a
   part of the crate the reader may not know.

### System docs

1. **Stale or long docs.** A system doc runs over 50 lines, contains a code sample, or states
   something the change made false.

### Sentence structure

1. **Reassigned words.** A later word forces the reader to change the role of an earlier word.
1. **Separated verbs.** Words stand between a verb and its subject, or between a verb and its
   object.
1. **Object relative clauses.** A subject stands between a noun and the verb that acts on that
   noun, with or without `that`.
1. **Unmarked modifiers.** A modifier starts without a word that marks the phrase as a modifier.
1. **Dropped words.** A sentence leaves out its subject, its verb or an article.
1. **Nested phrases.** A phrase sits inside another phrase rather than attaching to the end of
   the phrase before it.
1. **Reason clauses.** A clause starts with `since`, `as` or `because`. Fold the reason
   into the action first: into the object of the action, into a purpose that starts with `to`,
   or into a more exact verb. A comma followed by a trailing phrase is no fold. Keep the clause
   only when no fold keeps the meaning.
1. **Appended clauses.** A clause starts with `, which`.
1. **Run-on sentences.** Several ideas join through a semicolon or an em dash.

### Word choice

1. **Pronouns.** A pronoun such as `it`, `its`, `they`, `them`, `this` or `those` stands where
   the term could be repeated.
1. **Nominalization.** An action sits frozen in a noun, as in `performs an analysis of`.
1. **Phrasal verbs.** A two-word verb carries meanings that the parts do not predict, as in
   `spin up` or `kick off`.
1. **Long noun stacks.** More than three words stack into one noun phrase.
1. **Hedge stacking.** Qualifiers pile up until the sentence asserts nothing. State the claim,
   or delete the claim.
1. **Shifted hedges.** A rewrite makes a hedge stronger or weaker than the original.
1. **Quality adjectives.** A word claims quality in place of a measurement.
1. **Loose storage verbs.** `holds`, `keeps` or a similar verb stands where `stores` or
   `contains` describes where something is.
1. **Personal verbs.** A verb such as `hand`, `find`, `see`, `know`, `want`, `ask`, or `decide`
   describes a person where the code performs an operation the crate has a term for.

Rewrite every line that breaks a rule, and keep the meaning of the original line exactly. Where
a rewrite would drop a condition, a scope or a number, keep the longer wording and say so.

Report a comment that already follows the rules as correct. Never force a change onto a line
that needs none.

A rule fixes the form of a comment, and never the substance. A comment with nothing to say reads
as a short, clean comment with nothing to say, so delete the comment instead.