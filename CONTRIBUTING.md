# Contributing

Thanks for helping improve this skill.

## Ground rules

- Every new rule needs a before/after example pair, with the first line breaking the rule and the second following it.
- Add a matching item to the refinement pass checklist under the same section as the rule.
- Keep the skill's own prose in line with its rules. The skill should pass its own style pass.
- Bump `version` in the `SKILL.md` frontmatter and add a `CHANGELOG.md` entry for any behavior change.

## Workflow

1. Fork the repo and create a branch.
2. Edit `SKILL.md`.
3. Run `.github/scripts/validate.sh` locally to check the frontmatter.
4. Open a pull request describing which behavior changes and why.
