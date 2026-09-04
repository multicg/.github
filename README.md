# .github

`multicg` 계정 소유 저장소가 공유하는 기본 커뮤니티 파일·정책 저장소다.
개별 저장소가 자체 `.github/ISSUE_TEMPLATE`·`PULL_REQUEST_TEMPLATE.md`를
두지 않으면 GitHub이 이 저장소의 것을 기본값으로 적용한다.

`onandon-docs`(GitLab, `doonemo/workspace` 정책 상속)의 이슈·PR·브랜치
정책을 GitHub 환경에 맞춰 옮긴 것이다. 원본 구조는 유지하고,
GitLab·조직 전용 요소(taxonomy 자동검증 CI 등)는 뺐다 — 상세는
[CONTRIBUTING.md](./CONTRIBUTING.md) 참고.

## 이 저장소가 제공하는 것

| 항목 | 위치 | 적용 방식 |
|---|---|---|
| 이슈 템플릿 | `.github/ISSUE_TEMPLATE/` — 유형별 10종(`{bug,feature,change,security,quality,refactor,research,docs,ops,governance}.yml`, 원천 `doonemo/workspace` 유형별 템플릿, workspace@fc3189f, 2026-09-03 반영) + 유형 미정 초안용 `general_work.yml` | **수동** — GitHub은 YAML Issue Forms를 계정 레벨로 자동 상속하지 않는다(2026-08-26 GraphQL `issueTemplates` 실측 확인, compass-vault 등에서 `[]` 반환). 이미 있는 저장소에는 직접 복사해야 한다. ~~템플릿 저장소(`is_template: true`) 복사 생성~~은 2026-09-04부터 사용하지 않는다 — 생성 시점 스냅샷 복사는 원본 리비전 추적이 안 되므로, 새 저장소도 빈 저장소 생성 후 스킬 배포 경로를 쓴다([standards/repo-docs-standard.md](./standards/repo-docs-standard.md) §5). |
| PR 템플릿 | `.github/PULL_REQUEST_TEMPLATE.md` + `.github/PULL_REQUEST_TEMPLATE/*.md` | 자동(단일/레거시 파일 형식이라 계정 레벨 상속이 정상 동작 — GraphQL `pullRequestTemplates`로 확인) |
| 라벨 taxonomy(49종) | `labels.yml` | 수동 — 새 저장소마다 `scripts/apply-labels.sh <owner/repo>` 1회 실행 |
| markdownlint CI | `.github/workflows/markdownlint-reusable.yml` | 재사용 워크플로 — 각 저장소가 `uses:`로 호출 |
| 브랜치·이슈 정책 문서 | `CONTRIBUTING.md` | 참고 문서(자동 상속됨) |
| 문서 구조 표준 | [standards/repo-docs-standard.md](./standards/repo-docs-standard.md) (draft, §7 승격 게이트 참고) | 상세는 그 문서 §5 전파 규칙 참고. 제정 기록: [#7](https://github.com/multicg/.github/issues/7) |

> 상세 조사 근거: compass-vault
> `research/tech/github-account-level-issue-template-inheritance.md`

## 원본

- `onandon-docs`(`gitlab.doonemo.kr/onandon/onandon-docs`) — 이슈 등록
  규칙·라벨 taxonomy·PR/MR 템플릿 4종·markdownlint 설정의 원본
- `doonemo/workspace` — 위 정책의 조직 차원 원천(GitLab 전용, 이
  저장소로 옮기지 않은 부분: taxonomy 자동검증 CI, terminology CI)
