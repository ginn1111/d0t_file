#!/usr/bin/env python3
"""Verify the static Evondev Dracula bundle without installing it."""
from pathlib import Path
import os
import re
import subprocess
import tomllib

ROOT = Path(__file__).resolve().parent
EXPECTED_ANSI = (
    '#21222c', '#ff5555', '#20e3b2', '#fde181',
    '#bd93f9', '#ff6bcb', '#8be9fd', '#f8f8f2',
    '#8d92ff', '#ff6e6e', '#20e3b2', '#eac394',
    '#bd93f9', '#ff6bcb', '#2cccff', '#ffffff',
)
# Source: upstream Dracula-darker-contrast.json and the local #7f5cdf status override.
ALLOWED = set(EXPECTED_ANSI) | {
    '#141523', '#191a21', '#282a36', '#44475a', '#6272a4',
    '#7f848e', '#f1fa8c', '#ffb86c', '#7f5cdf',
}
for filename in ('herdr.toml', 'yazi.toml', 'starship.toml'):
    tomllib.loads((ROOT / filename).read_text())
    print(f'TOML OK: {filename}')
kitty = (ROOT / 'kitty.conf').read_text()
ansi = dict((int(i), color.lower()) for i, color in re.findall(
    r'^color(\d+)\s+(#[a-fA-F0-9]{6})$', kitty, flags=re.MULTILINE
))
assert ansi == dict(enumerate(EXPECTED_ANSI)), f'ANSI mismatch: {ansi}'
print('Kitty ANSI 0–15 exactly match upstream: OK')
for path in ROOT.rglob('*'):
    if not path.is_file() or path.suffix not in {'.toml', '.conf', '.lua', '.yaml'}:
        continue
    colors = {v.lower() for v in re.findall(r'#[a-fA-F0-9]{6}\b', path.read_text())}
    assert colors <= ALLOWED, f'{path}: unknown colors {colors - ALLOWED}'
print('All bundle config colors in the source/override palette: OK')
starship = tomllib.loads((ROOT / 'starship.toml').read_text())
assert starship['format'] == '$directory$git_branch$git_status$character'
assert starship['right_format'] == '' and starship['add_newline'] is False
print('Starship module order, empty right side, and no newline: OK')

def render_prompt(path: Path, *, isolate_git: bool = False, right: bool = False) -> str:
    env = dict(os.environ, STARSHIP_CONFIG=str(ROOT / 'starship.toml'), NO_COLOR='1')
    if isolate_git:
        env['GIT_CEILING_DIRECTORIES'] = str(ROOT.parent)
    else:
        env.pop('GIT_CEILING_DIRECTORIES', None)
    cmd = ['starship', 'prompt', '--path', str(path), '--logical-path', str(path)]
    if right:
        cmd.append('--right')
    return subprocess.run(cmd, cwd=path, env=env, check=True,
                          capture_output=True, text=True).stdout.strip('\n')

plain = render_prompt(ROOT, isolate_git=True)
in_repo = render_prompt(ROOT.parents[1])
assert all('\n' not in prompt and '❯' in prompt for prompt in (plain, in_repo))
assert '' not in plain and '' in in_repo
assert render_prompt(ROOT.parents[1], right=True) == ''
print('Starship one-line prompt outside/inside Git, branch and empty right: OK')
try:
    import yaml
except ImportError:
    print('LIMIT: PyYAML unavailable; YAML parse not checked')
else:
    skin = yaml.safe_load((ROOT / 'cindy-hermes.yaml').read_text())
    assert skin['name'] == 'evondev-dracula-cindy'
    assert all(re.fullmatch(r'#[a-fA-F0-9]{6}', c) for c in skin['colors'].values())
    print('Cindy Hermes YAML and color values: OK')
