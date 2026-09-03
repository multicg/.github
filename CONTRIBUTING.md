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
- 본문은 **유형별 이슈 템플릿**(`.github/ISSUE_TEMPLATE/{bug,feature,
  change,security,quality,refactor,research,docs,ops,governance}.yml` —
  유형마다 필수 절과 반려기준이 다르다)을 쓴다. 유형 미정 초안만
  `General Work` 폼(목적 → 배경 → 작업 내용 → 범위 → 완료 조건 →
  검증 방법 → 관련 항목 → Issue Contract JSON)을 쓴다. **API/CLI로
  이슈를 만들 때는 템플릿이 자동 적용되지 않으므로 해당 유형의 폼
  구조를 직접 따라 작성한다.**
  (원천: `doonemo/workspace` 유형별 템플릿 10종, workspace@fc3189f
  — 2026-09-03부터 적용)
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

## 과정 기록 이슈 (AI 에이전트 작업 — 계정 공용 기본값)

AI 에이전트(Claude Code 등)와 진행하는 실질 작업 — 문서 작성·개정,
리뷰 라운드, 설계 결정·방향 전환 — 은 결과물(커밋/PR)만 남기지 않고
**과정 자체를 해당 저장소의 이슈에 기록한다**. 커밋은 "무엇이
바뀌었나"만 남고 대화 채널(텔레그램 등) 보고는 휘발되므로, "왜
그렇게 결정했는가"와 "무엇을 검토하고 버렸는가"의 영구 기록은
이슈가 담당한다.

- **작업 단위(보통 feature 브랜치 = PR 1개)당 이슈 1개**를 생성한다.
  제목은 위 이슈 등록 규칙의 형식을 따른다(Type은 작업 성격에 맞게 —
  기록 중심이면 `docs`/`governance` 등).
- **턴 구조**: 이슈 본문은 목적 + 턴 인덱스(목차)만 유지하고, 실제
  기록은 **진행 턴 1개 = 코멘트 1개**로 쌓는다. 코멘트 제목은
  `[턴 N] <요지> — <커밋/날짜>` 형식. 턴이 발생한 시점에 실시간으로
  남긴다(몰아서 소급 기록하지 않는다 — 소급이 불가피했으면 발생
  순서와 코멘트 순서의 어긋남을 본문에 명시).
- **코멘트에 담을 것**: 리뷰 라운드 결과 요지, 사용자 결정(승인/
  보류/방침 지시), 방향 전환과 그 이유. "무엇을 했다"보다 **"왜
  그렇게 결정했다"**를 남기고, **보류·기각된 제안도 사유와 함께
  기록**한다 — 다음 세션(또는 다른 에이전트)이 같은 제안을
  재발명하거나 기각 이유를 모른 채 재적용하는 것을 막는다.
- PR 본문에 이슈 번호를 참조하고(`#N`), **PR 머지 시 정리 코멘트 후
  수동 종결**한다(이슈는 PR와 1:1이 아닐 수 있으므로 자동 close
  키워드보다 수동 종결이 기본).
- **에픽 분리 기준**: 한 작업이 **PR 2개 이상에 걸치거나** 독립적으로
  진행·종결되는 하위 작업으로 나뉘면 부모 이슈 + 하위 이슈(GitHub
  sub-issues)로 분리한다 — 하위 이슈가 각자의 턴 코멘트를 갖고,
  부모 이슈는 하위 인덱스와 전체 방향 결정만 담는다. 단일 PR 작업은
  이슈 1개로 충분하며 남발하지 않는다.
- 적용 사례: [compass-vault#44](https://github.com/multicg/compass-vault/issues/44).

## 기획-산출물 저장소 분리 (계정 공용 기본값)

문서 전용 저장소(기획·조사 볼트 등)에서 시작한 프로젝트가 코드
산출물(compose·스크립트·앱·서비스)을 갖게 되면 **별도 독립
저장소**로 진행한다 — 문서 저장소에 서브모듈로 넣지 않는다(문서
저장소의 정체성·히스토리가 서브모듈 SHA 범프로 오염되고, 문서와
코드는 리뷰·CI 흐름이 달라 한 체크아웃에 있을 이유가 없다).

- 기획 문서는 원 저장소에 존치하고, 구현 착수 시 문서 상단에 "구현
  저장소: <링크>" 포인터를 추가한다.
- 코드와 함께 진화할 스펙(스키마 DDL 등)만 새 저장소로 복사-이관하고,
  원본에 "이후 버전은 구현 저장소가 원본" 표기를 남긴다.
- 과정 기록 이슈는 각 저장소에 만들고 cross-repo
  참조(`owner/repo#N`)로 상호 링크한다 — 기획 이슈가 부모(에픽) 격,
  구현 이슈들이 하위 역할.

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
