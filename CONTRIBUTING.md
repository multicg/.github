# 브랜치·이슈·PR 정책 (계정 공용 기본값)

이 문서는 `multicg` 계정 소유 저장소가 별도 정책을 정하지 않는 한
따르는 기본값이다. `onandon-docs`(GitLab)의 정책을 GitHub 환경에
맞춰 옮긴 것 — 원본 구조는 같고, GitLab 전용 요소(taxonomy 자동검증
CI, `doonemo/workspace` include)는 뺐다.

## 이슈 등록 규칙

- 제목 형식: `[Type] primary-component: 검증 가능한 결과`
  (예: `[Bug] deployment: 배포 스크립트가 타임아웃보다 짧게 대기함`)
- **Type**(10종): `bug` `feature` `change` `security` `quality`
  `refactor` `research` `docs` `ops` `governance`
- **Component**(25종): `labels.yml`의 `comp:*` 참고
- 본문은 이슈 템플릿(`General Work`) 구조(목적 → 배경 → 작업 내용 →
  범위 → 완료 조건 → 검증 방법 → 관련 항목 → Issue Contract JSON)를
  따른다. **API/CLI로 이슈를 만들 때는 템플릿이 자동 적용되지
  않으므로 이 구조를 직접 따라 작성한다.**
- 라벨은 `labels.yml`에 49개 정의돼 있다: `type:*`(10)
  `comp:*`(25) `priority:p0~p4`(5) `severity:critical~informational`(5)
  `risk:critical~low`(4). 새 저장소에 처음 적용하려면
  `scripts/apply-labels.sh <owner/repo>`를 실행한다.
- 서술이 긴 항목(인시던트 재현·원인 분석 등)은 이슈 본문에 다 넣지
  않고 별도 문서로 작성한 뒤 이슈에서 링크한다.
- 완료된 작업 이슈는 닫는다. 원인 미해결이거나 추가 조사가 필요한
  이슈만 열어둔다.

이슈 제목 형식·taxonomy를 CI로 강제 검증하지는 않는다(GitLab 원본의
`issue_validator.py`에 해당하는 자동 검증은 이 저장소 세트로
옮기지 않았다) — 사람이 직접 판단한다.

## 브랜치 정책

`main`/`develop` 이원화(각 저장소가 실제로 이 모델을 쓸지는 저장소
성격에 따라 선택 — 코드 저장소는 보통 이 모델을 따른다):

- `feature/<slug>` 브랜치 → `develop`으로 PR
- `develop` 통합 완료 후 별도 PR로 `main`으로 승격
- `main`/`develop` 직접 push 금지 — 브랜치 보호 규칙으로 강제
- 커밋 prefix: `feat:`(신규 기능) `fix:`(버그 수정) `docs:`(문서)
  `chore:`(구조 변경) — `update:`/`wip:`/`tmp:` 금지

## PR 템플릿

`.github/PULL_REQUEST_TEMPLATE.md`(기본) + 유형별
`.github/PULL_REQUEST_TEMPLATE/{bug_fix,feature,revert}.md`(PR 생성
화면에서 `?template=` 쿼리로 선택).

## CI

`markdownlint`는 재사용 워크플로(`.github/workflows/markdownlint-reusable.yml`)로
제공한다. 호출하는 저장소는 아래처럼 워크플로 파일 하나만 추가하면
된다:

```yaml
name: markdownlint
on: [pull_request]
jobs:
  markdownlint:
    uses: multicg/.github/.github/workflows/markdownlint-reusable.yml@main
```
