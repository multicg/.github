#!/usr/bin/env bash
# labels.yml(이 저장소 루트)의 라벨 정의를 대상 GitHub 저장소에 생성/갱신한다.
# 이미 있는 라벨은 색상·설명을 갱신하고, 없는 라벨은 새로 만든다.
# 이 파일이 라벨 taxonomy의 단일 원본이다 — 대상 저장소에 라벨셋을
# 복제해두지 않는다(새 라벨이 추가되면 이 스크립트를 다시 돌린다).
#
# 사용: apply-labels.sh <owner/repo>
# 사전 조건: gh auth status로 인증돼 있어야 하고, PyYAML이 필요 없도록
# 파싱은 python3 표준 라이브러리만으로 최소한으로 처리한다.
set -euo pipefail

TARGET_REPO="${1:?사용: apply-labels.sh <owner/repo>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABELS_FILE="$SCRIPT_DIR/../labels.yml"

command -v gh >/dev/null 2>&1 || { echo "오류: gh(GitHub CLI)가 설치돼 있지 않음" >&2; exit 1; }
[ -f "$LABELS_FILE" ] || { echo "오류: labels.yml을 찾을 수 없음 - $LABELS_FILE" >&2; exit 1; }

python3 - "$LABELS_FILE" <<'PYEOF' | while IFS=$'\t' read -r name color description; do
import re
import sys

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    text = f.read()

# 최소 파서: "- name: ...\n  color: ...\n  description: ..." 3줄 묶음만 지원한다
# (labels.yml이 이 구조를 벗어나면 이 스크립트도 함께 고친다 — PyYAML
# 의존을 피하려고 일부러 정규식으로 최소 구현했다).
entries = re.findall(
    r'-\s*name:\s*"([^"]+)"\s*\n\s*color:\s*"([^"]+)"\s*\n\s*description:\s*"([^"]*)"',
    text,
)
for name, color, description in entries:
    print(f"{name}\t{color}\t{description}")
PYEOF
  if gh label list --repo "$TARGET_REPO" --limit 300 --json name -q '.[].name' 2>/dev/null | grep -qxF "$name"; then
    gh label edit "$name" --repo "$TARGET_REPO" --color "$color" --description "$description" >/dev/null
    echo "갱신: $name"
  else
    gh label create "$name" --repo "$TARGET_REPO" --color "$color" --description "$description" >/dev/null
    echo "생성: $name"
  fi
done

echo "완료 — $TARGET_REPO"
