# documentation-style

[![Validate skill](https://github.com/djhenry/documentation-style-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/djhenry/documentation-style-skill/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A [Claude Code](https://claude.com/claude-code) skill that makes Claude rewrite the comments and docs it writes in a Rust crate against a strict, explicit style guide.

Left alone, an LLM writes comments that drift: synonyms for the same concept, passive descriptions of code, vague reasons, stray colons and semicolons. This skill turns a house style into a checklist Claude runs after every change that touches documentation.

## What it does

When Claude writes or edits a doc comment, an inline comment or a system doc, the skill triggers a two-step pass:

1. **Write to the rules** while making the change.
2. **Re-read every touched line** against a refinement checklist, because writing and refining catch different faults.

Every rule comes with a before/after example pair, so the behavior is concrete rather than vibes.

## Rule areas

| Area | Examples of what it enforces |
| --- | --- |
| Terminology | One term per concept, no synonym rotation, announce new terms |
| Inline comments | Imperative mood, lowercase, noun phrases for state, no colons |
| Doc comments | One-sentence summary, absent results explained, `Constructs a new [`Type`]` for constructors, third person simple present |
| System docs | Under 50 lines, no code samples, updated in the same change as the behavior |
| Sentence structure | No reassigned words, verbs beside objects, reasons folded into actions, no `, which`, no semicolons or em dashes |
| Word choice | No pronouns where the term can repeat, no nominalizations, no quality adjectives, preserved hedge strength |

## Example

```rust
// before
// set the leaves a filled gridtree node covers to `Leaf::Filled`

// after
// set the leaves covered by a filled gridtree node to `Leaf::Filled`
```

## Install

Copy the skill into your Claude Code skills directory:

```sh
mkdir -p ~/.claude/skills/documentation-style
curl -fsSL https://raw.githubusercontent.com/djhenry/documentation-style-skill/main/SKILL.md \
  -o ~/.claude/skills/documentation-style/SKILL.md
```

Or clone the repo and symlink it:

```sh
git clone https://github.com/djhenry/documentation-style-skill.git
ln -s "$PWD/documentation-style-skill" ~/.claude/skills/documentation-style
```

Claude loads the skill automatically when a response writes or edits documentation. You can also invoke it by name with `/documentation-style`.

## Adapting it

The rules reference a specific crate's vocabulary (for example `gridtree` and `BLAS`) in the examples. To use the skill on another project, keep the structure and replace the examples and the terminology rules with your own.

## Repository layout

```
SKILL.md      the skill itself, with frontmatter and rules
README.md     this file
CHANGELOG.md  version history
LICENSE       MIT
```

## Contributing

Issues and pull requests are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE)
