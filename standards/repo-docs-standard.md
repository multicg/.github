# repo-docs-standard — 개인 저장소 문서 구조 표준

| 항목 | 값 |
|---|---|
| 버전 | 1.0.0 |
| 상태 | active |
| 정본 위치 | `multicg/.github` `standards/repo-docs-standard.md` (이 파일) |
| 상류 참조 | `doonemo/workspace` `guides/docs-classification-guide.md` (workspace@fc3189f, 2026-09-04 반영) |
| 제정 근거 | [multicg/.github#7](https://github.com/multicg/.github/issues/7) (조사·결정 기록) |

## 1. 목적과 적용 범위

`multicg` 개인 저장소 전체(GitHub·GitLab 불문)의 문서 구조를 하나의
표준으로 통일한다. 저장소마다 문서 분류 체계를 새로 발명하지 않고,
이 표준의 **base 규칙**(어휘·분류 기준·파일명)과 **repo-type
오버레이**(유형별 물리 배치)를 적용한다.

구조는 2계층이다:

```text
base 표준        — 모든 저장소 공통: 문서 유형 어휘, 분류 결정 트리,
                   파일명 규칙, 과정 기록 경계, 보류 레지스터
repo-type 오버레이 — 저장소 유형별 물리 배치: implementation형 / vault형
```

이 2계층 설계의 근거: 문서 "유형" 어휘는 저장소가 달라도 공통이지만,
물리 배치는 저장소의 본질에 따라 달라진다 — 구현 저장소는 문서
유형별 버킷이 맞고, 기획 볼트는 프로젝트 단위 응집(통째 이관을
전제)이 맞다. 상세 검증 기록은 [multicg/.github#7](https://github.com/multicg/.github/issues/7) 참고.

## 2. 상류 참조 규칙 — doonemo/workspace

`doonemo/workspace`(GitLab)는 이 표준의 상류 참조다. **읽기 전용** —
내 담당 저장소가 아니므로 쓰기 작업을 하지 않는다.

- 이 표준은 workspace의 분류 체계를 개인 저장소 맥락에 맞게 개작한
  것이며, 반영 시점의 리비전을 문서 머리에 `workspace@<sha>`로
  기록한다.
- workspace 쪽 정책이 바뀌면: 스킬(§5)이 diff를 보여주고, **수동
  채택 여부만 결정**한다 — 자동 추종하지 않는다.

## 3. base 표준 (모든 저장소 공통)

### 3.1 문서 유형 어휘

저장소를 불문하고 문서는 아래 유형 중 하나로 식별한다.

| 유형 | 정의 | 예 |
|---|---|---|
| requirement | 요구사항·기획 — PRD, 기능 스펙, 입출력 스키마 | PRD, batch-input-spec |
| architecture | 구조·경계 — 저장소 구조, 모듈 경계, 시스템 구성 | repository-structure |
| decision | 의사결정 기록 — 무엇을 왜 선택/보류/기각했는지 | 게이트 판정, ADR |
| operation | 운영 — 절차, 체크리스트, 정책, 작업 계획 | 수집 정책, 파일럿 체크리스트 |
| research | 조사 — 시장·기술·실사 기록, 외부 자료 정리 | 시장조사, 실사 기록 |
| guide | 방법·절차(how-to) — 따라 하면 결과가 나오는 문서 | 온보딩, 도구 사용법 |
| template | 재사용 양식 | 리서치 노트 템플릿 |

### 3.2 분류 결정 트리

새 문서를 만들 때 위에서부터 순서대로 묻는다. 먼저 해당되는 곳이
유형이다.

1. 재사용할 양식인가? → template
2. 어떤 선택의 배경과 이유를 남기는 기록인가? → decision
3. "어떻게 하는지"를 단계별로 알려주는가? → guide
4. 무엇을 만들지(요구·기능·스키마)를 정의하는가? → requirement
5. 시스템·저장소의 구조와 경계를 설명하는가? → architecture
6. 절차·정책·체크리스트·작업 계획인가? → operation
7. 조사·실사·외부 자료 정리인가? → research
8. 어디에도 해당하지 않으면 → 저장소 docs 루트에 두고, 반복되면 이
   표준에 유형 추가를 제안하는 이슈를 정본 저장소(multicg/.github)에
   연다.

**도구가 경로를 강제하는 양식은 예외** — GitHub 이슈 템플릿은
`.github/ISSUE_TEMPLATE/`, GitLab은 `.gitlab/issue_templates/` 등
플랫폼 고정 경로를 따른다.

### 3.3 과정 기록과 규범 문서의 경계 (필수)

- **과정 기록**(누가·언제·왜 그렇게 진행했는가)의 정본은 **깃 이슈**다
  — 작업 단위마다 이슈 1개, 진행 턴마다 코멘트 1개.
- **규범 문서**(현재 유효한 규칙·판정·스펙)만 파일로 남긴다.
- 같은 결정을 이슈와 파일 양쪽에 중복 서술하지 않는다 — 파일에는
  결론(규범)만, 도출 과정은 이슈 링크로 대신한다.
- 이 경계 때문에 "아이디어 인큐베이션·브레인스토밍"은 폴더가 아니라
  이슈로 접수한다(§4.2 vault형 참고).

### 3.4 보류 레지스터 (deferred)

의사결정 기록에는 채택한 것만 남기 쉽지만, 나중에 비싸지는 쪽은
"지금은 안 하기로 한 것"이다.

- 보류·기각의 **이유**는 해당 decision 문서에 적는다.
- **다시 꺼낼 조건**은 저장소당 하나의 레지스터(`docs/decisions/deferred.md`)에
  모은다. 조건은 관찰 가능한 사건으로 쓴다 — "필요해지면"은 조건이
  아니다.
- 조건이 충족돼 처리되면 지우지 말고 "해소됨" 표로 옮긴다.

### 3.5 파일명·공통 규칙

- 영문 kebab-case. 내용이 드러나는 이름 + 성격 접미사(`-spec`,
  `-guide`, `-decision` 등).
- 날짜가 의미 있는 문서는 `YYYY-MM-DD-` 접두.
- 이슈에서 시작된 문서는 본문에 관련 이슈 번호(#N)를 명시한다.
- 디렉터리는 첫 문서가 생길 때 만든다 — 빈 디렉터리를 미리 만들지
  않는다.
- 문서 추가·디렉터리 신설 등 구조에 영향을 주는 변경은 같은 PR에서
  저장소 README(구조 표)를 함께 갱신한다.

## 4. repo-type 오버레이

저장소는 AGENTS.md에 자신의 repo-type을 명시한다. 물리 배치는
유형별 오버레이를 따른다.

### 4.1 implementation형 — 구현 저장소

코드가 본체이고 문서는 그 근거·계약인 저장소. 문서는 유형별 버킷에
분산 배치한다.

```text
docs/
  planning/      requirement 유형 — PRD, 스펙, 스키마, 템플릿
  architecture/  architecture 유형 — 저장소 구조, 모듈 경계
  operations/    operation 유형 — 정책, 체크리스트, 작업 계획, 운영 절차
  decisions/     decision 유형 — 게이트 판정, ADR, deferred.md
  research/      research 유형 — 조사·실사 기록, sources/
```

- guide 유형이 생기면 `docs/guides/`를 그때 만든다(§3.5 빈 디렉터리
  금지).
- 기획 볼트에서 이관(graduation)받은 문서 세트는 유형별로 분류해
  배치한다 — 이관 매핑은 §4.2 참고.

### 4.2 vault형 — 기획 볼트

문서 자체가 제품이고, 프로젝트 단위 응집·통째 이관이 본질인 저장소
(예: compass-vault). 유형별 분산이 아니라 **프로젝트 패키지** 중심으로
배치한다.

```text
plans/
  active/<slug>/   진행 중 프로젝트 패키지 — prd-<slug>.md 중심으로
                   스펙·다이어그램·sources/ 응집
  archive/         보류·종료 기획 — 사유를 문서 상단에 명시
research/          주제별 조사 (tech/, market/, opensource/ 등)
templates/         재사용 양식
```

vault형 필수 규칙:

- **아이디어는 폴더가 아니라 이슈로 접수한다.** 채택되면 research/
  또는 plans/로 직행한다. (근거: 아이디어 폴더는 이슈 기반 과정
  기록과 역할이 중복되어 실사용되지 않음이 실증됨 — multicg/.github#7)
- **수명 상태의 정본은 폴더 위치다** — `plans/active/` ↔
  `plans/archive/` 이동이 상태 전환이고, frontmatter `status`는
  검색용 미러로 폴더 위치와 항상 일치시킨다.
- **graduation(구현 저장소 이관) 규칙**:
  1. 이관 시점에 볼트 쪽 문서 상단에 스냅샷 동결 표기와 구현 저장소
     포인터를 남긴다 — "이 시점 이후 버전은 <저장소>가 원본".
  2. 이관 매핑: `plans/active/<slug>/`의 문서를 대상 저장소의
     implementation형 버킷으로 유형별 분류해 배치한다
     (PRD·스펙 → `docs/planning/`, decision-log 중 규범 결정 →
     `docs/decisions/`, 조사 → `docs/research/`).
  3. 이관 후 볼트 쪽 패키지는 `plans/archive/`로 이동한다.

### 4.3 범위 외 — docs-delivery형

납품 문서 저장소(예: ssis-docs류)는 발주처 번호 체계 등 자체 구조를
따르며 이 표준의 오버레이를 적용하지 않는다. base 표준 중 파일명
규칙(§3.5)도 발주처 관례가 우선한다.

## 5. 전파 규칙

- **정본은 이 저장소**(multicg/.github)다. 각 저장소의 구조·AGENTS.md
  표준 절은 배포된 복사본이다.
- 배포·대조는 sensus 플러그인의 범용 스킬(`sensus:repo-docs-standard`)이
  담당한다: 대상 저장소를 표준과 대조(check)하고, 어긋난 곳에
  policy-sync PR을 만든다(write). 커밋 메시지의 `.github@<sha>`가
  원본 리비전이다.
- **생성 시점 복사 금지** — 새 저장소를 템플릿 복사로 만들지 않는다.
  빈 저장소 생성 후 스킬 1회 실행이 유일한 부트스트랩 경로다. 배포는
  항상 정본 sha 마커가 박힌 추적 가능한 PR이어야 한다.
- 배포된 복사본을 저장소에서 직접 수정하지 않는다 — 고치고 싶으면 이
  저장소에 이슈를 연다. 수정하면 다음 check가 드리프트로 보고한다.
- GitLab 개인 프로젝트에도 같은 스킬로 배포한다(플랫폼별 경로 차이는
  스킬이 흡수한다).

## 6. 개정 절차

1. 변경 제안은 이 저장소 이슈로 연다 (과정 기록 규칙 §3.3 준수).
2. 합의된 변경은 이 파일을 PR로 수정하고 버전을 올린다.
3. 상류(workspace) 변경 반영 시 머리의 `workspace@<sha>`를 갱신한다.
4. 개정 후 스킬 check를 돌려 배포 대상 저장소들의 드리프트를 확인하고
   재배포 PR을 만든다.
