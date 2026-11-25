# Public repository release gate

Do not change the repository's visibility merely because a historical secret
was removed from the current working tree.

## Private evidence collection

Use a trusted computer or a private runner that is allowed to access this
repository. Keep the repository and audit output private. Use an existing
full mirror where available; otherwise authenticate Git securely and clone
with `git clone --mirror`. Do not put credentials in the remote URL or shell
history. Fetch all branches and tags and explicitly account for accessible
pull-request refs, forks, LFS, submodules and any archived repositories.

Run the version of the audit script from this reviewed branch against the
mirror (or full checkout). It scans reachable object contents, including
deleted files and commit/tag messages, and produces a private JSON report
outside the repository:

```bash
python3 scripts/audit-public-release.py /path/to/private/kyron.git \
  --report /protected/path/kyron-history-audit.json
```

Exit 0 means the implemented checks found no candidates, not clearance.
Exit 1 means candidates need review. Exit 2 means coverage is incomplete or
the tool failed. The script never prints matched values. It does not extract
archives, validate live credentials, or inspect GitHub's remote-only
objects. Review all flagged paths, binary objects, generated bundles and
skipped objects; do not silently allowlist a real historical credential.

Independently install a trusted, verified current Gitleaks release and scan
the same mirror with full history and redaction. Keep reports private:

```bash
umask 077
gitleaks git /path/to/private/kyron.git --log-opts="--all --full-history" \
  --redact=100 --report-format=json \
  --report-path=/protected/path/kyron-gitleaks.json
```

Inspect retained Actions logs/artifacts, release assets (including nested
archives and compiled clients), issue/PR comments and attachments, release
descriptions, wiki, Pages, and any other data exposed by a visibility change.
Do not publish audit output. Rotate/revoke every confirmed sensitive
credential at its provider before cleaning history.

## Cutover controls

- Verify the replacement development signing certificate and a successful
  official four-APK build. The Play upload and app-signing keys are separate.
- Verify all current runtime credentials and signing modes; preserve a
  recovery backup and use coordinated rotation, not mass key replacement.
- Enable private vulnerability reporting; require maintainer approval of
  external workflows and changes to protected main, release tags and
  signing/upload environments. Keep default GITHUB_TOKEN permissions
  read-only and never send production secrets to untrusted fork code.
- Configure GitHub secret scanning and push protection where available.
- Verify database grants/RLS, auth settings, migration checks and required
  integration tests. No live financial activation is part of publication.
- Confirm software-license and brand/trademark policy with the owner.
- Record the greatest existing Play versionCode and development build
  number before any history rewrite. Preserve monotonic numbering after
  rewriting; do not blindly reset the count. Test proposed history on an
  isolated mirror. Back up old history privately, coordinate with all
  collaborators, and obtain explicit approval before force-pushing.
- Ask GitHub Support about cached objects and pull-request references after
  approved sensitive-data removal. Inspect all remaining logs/assets and
  independently rescan the actual publication candidate.

A cleared current tree is not a cleared historical repository. A clean
scanner run is not proof that unknown secrets do not exist. Publication
requires an owner-approved evidence checklist and completed remediation.

References:
- https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository
- https://github.com/gitleaks/gitleaks
