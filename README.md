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
| 이슈 템플릿 | `.github/ISSUE_TEMPLATE/general_work.yml` | 자동(개별 저장소에 템플릿 없으면 이걸 씀) |
| PR 템플릿 | `.github/PULL_REQUEST_TEMPLATE.md` + `.github/PULL_REQUEST_TEMPLATE/*.md` | 자동 |
| 라벨 taxonomy(49종) | `labels.yml` | 수동 — 새 저장소마다 `scripts/apply-labels.sh <owner/repo>` 1회 실행 |
| markdownlint CI | `.github/workflows/markdownlint-reusable.yml` | 재사용 워크플로 — 각 저장소가 `uses:`로 호출 |
| 브랜치·이슈 정책 문서 | `CONTRIBUTING.md` | 참고 문서 |

## 원본

- `onandon-docs`(`gitlab.doonemo.kr/onandon/onandon-docs`) — 이슈 등록
  규칙·라벨 taxonomy·PR/MR 템플릿 4종·markdownlint 설정의 원본
- `doonemo/workspace` — 위 정책의 조직 차원 원천(GitLab 전용, 이
  저장소로 옮기지 않은 부분: taxonomy 자동검증 CI, terminology CI)
