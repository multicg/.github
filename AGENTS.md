# AGENTS.md — .github (multicg 계정 공용 커뮤니티 파일·정책 저장소)

## 이 저장소가 무엇인가

`multicg` GitHub 계정 소유 저장소 전체가 공유하는 **커뮤니티 파일·정책의
원본(source of truth)**이다. 저장소 이름이 `.github`이기 때문에 GitHub이
일부 파일(PR 템플릿 등)을 계정 레벨 기본값으로 자동 상속시킨다. 상세 배경과
근거는 `README.md`, 정책 본문은 `CONTRIBUTING.md`를 참고 — 이 문서는
"에이전트가 이 저장소를 건드리기 전에 알아야 할 것"만 다룬다.

원본은 `onandon-docs`(GitLab, `doonemo/workspace` 정책 상속)이며, GitLab
전용 요소(taxonomy 자동검증 CI 등)는 뺀 GitHub용 이식본이다.

## 무엇이 자동 상속되고 무엇이 안 되는지 (가장 중요한 사실)

GitHub의 계정 레벨 `.github` 상속은 **파일 형식에 따라 동작이 다르다**
(2026-08-26 GraphQL `issueTemplates`/`pullRequestTemplates` 실측 확인,
`README.md` 표 참고):

| 파일 | 자동 상속 여부 |
|---|---|
| `.github/PULL_REQUEST_TEMPLATE.md` + `PULL_REQUEST_TEMPLATE/*.md` | 자동 (단일/레거시 형식) |
| `.github/ISSUE_TEMPLATE/*.yml` (YAML Issue Forms) | **자동 안 됨** — 새 저장소에 수동 복사하거나 `gh repo create --template multicg/.github <name>`로 템플릿 저장소 복제 필요 |
| `labels.yml` (49종 taxonomy) | 자동 안 됨 — 저장소마다 `scripts/apply-labels.sh <owner/repo>` 실행 필요 |
| `.github/workflows/markdownlint-reusable.yml` | 자동 안 됨 — 각 저장소가 `uses: multicg/.github/.github/workflows/markdownlint-reusable.yml@main`로 명시 호출 |

이 구분을 모르고 "이 저장소를 고치면 다 자동으로 퍼지겠지"라고 가정하면
안 된다. 이슈 템플릿·라벨·워크플로는 **다른 저장소들에 이미 배포된
사본**이 따로 있고, 이 저장소는 그 사본들의 원본일 뿐이다.

## 수정 시 주의사항 — 파급 범위가 크다

이 저장소의 파일을 고치는 것은 로컬 변경이 아니라 **정책 개정**이다.

- `labels.yml`을 바꾸면 이미 라벨을 적용받은 모든 저장소가 구식 상태가
  된다 — 새 라벨 추가/색상 변경 시 영향받는 저장소마다
  `scripts/apply-labels.sh <owner/repo>`를 다시 돌려야 실제로 반영된다.
  이 스크립트를 안 돌리면 이 파일의 변경은 "문서상으로만" 존재한다.
- `.github/workflows/markdownlint-reusable.yml`의 규칙(`MD013` 끄기 등)을
  바꾸면 이 워크플로를 `uses:`로 호출하는 **모든** 저장소의 다음 PR부터
  즉시 영향을 받는다 — 되돌리기 전에 규칙 완화/강화가 의도한 것인지
  재확인한다.
- `.github/ISSUE_TEMPLATE/general_work.yml`이나 `CONTRIBUTING.md`의 이슈
  등록 규칙(제목 형식, Type/Component taxonomy)을 바꾸면 이미 이 구조를
  따르는 다른 저장소들과 규칙이 어긋난다 — 가능하면 기존 저장소들에도
  변경을 전파하거나, 최소한 이 저장소의 README/CONTRIBUTING에 "언제부터
  바뀌었는지" 명시한다.
- `apply-labels.sh`의 파서는 `labels.yml`의 3줄 고정 포맷
  (`name`/`color`/`description`, 큰따옴표 필수)에 의존하는 정규식 최소
  구현이다 — `labels.yml` 포맷을 바꾸면 스크립트도 함께 고쳐야 한다.

## 검증

이 저장소 자체에는 로컬 실행형 테스트/빌드 스크립트가 없다. 실제로
존재하는 검증 수단은 다음 둘뿐이다.

- **markdownlint**: 로컬에 `.markdownlint-shared.yml`을 두지 않는다 —
  규칙은 `.github/workflows/markdownlint-reusable.yml` 안에 인라인으로
  박혀 있고, PR 변경 파일만 검사한다(전체 스캔 아님). 로컬에서 같은
  규칙으로 확인하려면 워크플로 파일 안의 `cat > .markdownlint-shared.yml`
  블록 내용을 그대로 복사해 `npx markdownlint-cli2 --config
  <임시파일> <바꾼 .md 파일들>`로 돌린다.
- **라벨 적용 확인**: `scripts/apply-labels.sh <owner/repo>`를 실제
  대상 저장소에 돌려보고 `gh label list --repo <owner/repo>` 출력으로
  49종이 반영됐는지 확인한다. `gh auth status`로 인증돼 있어야 한다.

## 브랜치·PR

`CONTRIBUTING.md`의 정책이 이 저장소 자체에도 그대로 적용된다: `main`
직접 push 금지, `feature/<slug>` → PR, 커밋 prefix는 `docs:`/`fix:`/
`chore:`(`update:`/`wip:`/`tmp:` 금지). 구조 변경(디렉터리·정책 파일
추가/변경) PR은 같은 PR 안에서 `README.md`를 함께 갱신한다 — PR 템플릿
체크리스트에도 명시돼 있다.
