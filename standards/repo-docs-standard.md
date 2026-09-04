# repo-docs-standard — 개인 저장소 문서 구조 표준

| 항목 | 값 |
|---|---|
| 버전 | 1.0.0-draft |
| 상태 | draft — `sensus:repo-docs-standard` 스킬 미구현 + implementation형 1호(replica-community-intelligence) 이관 완료가 `active` 승격 게이트. 승격 조건은 §7 참고 |
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
| decision | 의사결정 기록 — 채택한 결론과 기각한 대안의 사유 한 줄(§3.3 참고) | 게이트 판정, ADR |
| operation | 운영 — 절차, 체크리스트, 정책, 작업 계획 | 수집 정책, 파일럿 체크리스트 |
| research | 조사 — 시장·기술·실사 기록, 외부 자료 정리 | 시장조사, 실사 기록 |
| guide | 방법·절차(how-to) — 따라 하면 결과가 나오는 문서 | 온보딩, 도구 사용법 |
| template | 재사용 양식 | 리서치 노트 템플릿 |

### 3.2 분류 결정 트리

새 문서를 만들 때 위에서부터 순서대로 묻는다. 먼저 해당되는 곳이
유형이다.

1. 재사용할 양식인가? → template
2. 어떤 선택의 배경과 이유를 남기는 기록인가? → decision
3. 반복 재사용되는 how-to(누가 언제 읽어도 같은 절차)인가? → guide
4. 이 저장소·프로젝트 한정 1회성 계획·정책·체크리스트인가? → operation
5. 무엇을 만들지(요구·기능·스키마)를 정의하는가? → requirement
6. 시스템·저장소의 구조와 경계를 설명하는가? → architecture
7. 조사·실사·외부 자료 정리인가? → research
8. 어디에도 해당하지 않으면 → implementation형은 저장소 docs 루트,
   vault형은 research/에 두고, 반복되면 이 표준에 유형 추가를
   제안하는 이슈를 정본 저장소(multicg/.github)에 연다.

**guide vs operation 판별 기준**: "다른 사람·다른 시점에도 똑같이
따라 하면 되는 절차"면 guide, "이 저장소에서 지금 이 계획을 어떻게
진행할지"면 operation이다. 예: "PR 올리는 법"은 guide, "이번 파일럿
체크리스트"는 operation.

**도구가 경로를 강제하는 양식은 예외** — GitHub 이슈 템플릿은
`.github/ISSUE_TEMPLATE/`, GitLab은 `.gitlab/issue_templates/` 등
플랫폼 고정 경로를 따른다.

### 3.3 과정 기록과 규범 문서의 경계 (필수)

- **과정 기록**(토론·검토·왜 그 논의에 이르렀는가)의 정본은 **깃
  이슈**다 — 작업 단위마다 이슈 1개, 진행 턴마다 코멘트 1개.
- **규범 문서**(decision 유형 등)에는 **채택한 결론**과 **기각한
  대안의 사유 한 줄**까지만 적는다. 논의 경위·검토 과정은 이슈
  링크로 대신한다 — "왜 그 결론에 도달했는가"의 상세는 이슈,
  "무엇을 결정했고 무엇을 안 하기로 했는가"의 요약은 파일.
- 같은 내용을 이슈와 파일 양쪽에 중복 서술하지 않는다.
- 이 경계 때문에 "아이디어 인큐베이션·브레인스토밍"은 폴더가 아니라
  이슈로 접수한다(§4.2 vault형 참고).

### 3.4 보류 레지스터 (deferred)

의사결정 기록에는 채택한 것만 남기 쉽지만, 나중에 비싸지는 쪽은
"지금은 안 하기로 한 것"이다.

- 보류·기각의 **이유**는 해당 decision 문서에 적는다.
- **다시 꺼낼 조건**은 저장소당 하나의 레지스터에 모은다. 레지스터의
  정확한 경로는 오버레이가 정한다(implementation형은
  `docs/decisions/deferred.md` — §4.1). 조건은 관찰 가능한 사건으로
  쓴다 — "필요해지면"은 조건이 아니다.
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

저장소는 AGENTS.md에 자신의 repo-type을 아래 고정 형식의 한 줄로
명시한다 — 스킬(§5)이 이 줄을 파싱해 오버레이를 판별한다:

```text
repo-type: implementation
```

값은 `implementation` / `vault` / `docs-delivery` 중 하나. 이 줄이
없거나 값이 셋 중 하나가 아니면 스킬은 배포를 보류하고 사람에게
묻는다 — 오분류를 자동으로 잡을 수단은 없으므로(오선언은 사람
리뷰 대상, §5 참고) 값이 있는지·형식이 맞는지만 기계 검증한다.

물리 배치는 유형별 오버레이를 따른다.

### 4.1 implementation형 — 구현 저장소

코드가 본체이고 문서는 그 근거·계약인 저장소. 문서는 유형별 버킷에
분산 배치한다.

```text
docs/
  planning/      requirement 유형 — PRD, 스펙, 스키마
  architecture/  architecture 유형 — 저장소 구조, 모듈 경계
  operations/    operation 유형 — 정책, 체크리스트, 작업 계획, 운영 절차
  decisions/     decision 유형 — 게이트 판정, ADR, deferred.md
  research/      research 유형 — 조사·실사 기록, sources/
```

- template 유형 문서가 생기면 `docs/templates/`를 그때 만든다(§3.5
  빈 디렉터리 금지 — planning/에 섞지 않는다, template은 독립
  유형이다).
- guide 유형이 생기면 `docs/guides/`를 그때 만든다(같은 이유).
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
  archive/         종료된 기획 — 문서 상단에 사유 태그 명시
research/          주제별 조사 (tech/, market/, opensource/ 등)
templates/         재사용 양식
```

`archive/` 사유 태그는 아래 중 하나로 통일한다(검색·통계 목적):

| 태그 | 의미 |
|---|---|
| `graduated` | 구현 저장소로 이관 완료(§ graduation 규칙 참고) |
| `on-hold` | 보류 — 다시 꺼낼 조건이 있으면 함께 명시 |
| `rejected` | 기각 — 채택하지 않기로 확정 |

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
  3. 이관 후 볼트 쪽 패키지는 사유 태그 `graduated`로 `plans/archive/`에
     이동한다.

### 4.3 범위 외 — docs-delivery형

납품 문서 저장소(예: ssis-docs류)는 발주처 번호 체계 등 자체 구조를
따르며 이 표준의 오버레이를 적용하지 않는다. base 표준 중 파일명
규칙(§3.5)도 발주처 관례가 우선한다.

## 5. 전파 규칙

- **정본은 이 저장소**(multicg/.github)다. 각 저장소의 구조·AGENTS.md
  표준 절은 배포된 복사본이다.
- 배포·대조는 sensus 플러그인의 범용 스킬(`sensus:repo-docs-standard`)이
  담당한다: 대상 저장소를 표준과 대조(check)하고, 어긋난 곳에
  policy-sync PR을 만든다(write).
- **원본 리비전 마커는 대상 저장소의 파일에 기록한다** — 커밋
  메시지가 아니다(커밋 메시지는 squash·rebase에서 유실된다). 대상
  저장소 AGENTS.md의 표준 절 머리에 `<!-- repo-docs-standard@<sha> -->`
  형식으로 남기고, check는 이 마커와 정본의 현재 sha를 파일 대 파일로
  비교한다.
- **check가 검증하는 범위(기계 검증)**: ① AGENTS.md의 `repo-type:`
  선언 존재·값 유효성, ② `repo-docs-standard@<sha>` 마커와 정본 sha
  일치 여부, ③ 오버레이(§4)가 정의한 필수 버킷 디렉터리 존재 여부,
  ④ 파일명 kebab-case(§3.5). 분류 정확성·§3.3 이슈/파일 중복 여부·
  §3.4 보류 조건의 품질은 기계 검증 대상이 아니다 — policy-sync PR
  리뷰 시 사람이 확인한다.
- **생성 시점 복사 금지** — 새 저장소를 템플릿 복사로 만들지 않는다.
  빈 저장소 생성 후 스킬 1회 실행이 유일한 부트스트랩 경로다. 배포는
  항상 정본 sha 마커가 박힌 추적 가능한 PR이어야 한다.
  **과도기 조항** — `sensus:repo-docs-standard` 스킬이 아직 없는
  동안은 수동 복사 + AGENTS.md에 sha 마커 수기 기록으로 대신한다.
  이 조항은 스킬 배포 완료 시 삭제한다(§7 게이트 참고).
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

## 7. draft → active 승격 게이트

이 표준은 `1.0.0-draft` 상태로 시작한다. 아래 조건이 모두 충족되면
버전을 `1.0.0`으로 올리고 상태를 `active`로 승격한다 — 승격 자체도
§6 개정 절차(PR)를 따른다.

1. `sensus:repo-docs-standard` 스킬이 배포되어 check/write를 실제로
   수행할 수 있다.
2. implementation형 1호(replica-community-intelligence,
   [replica#20](https://github.com/multicg/replica-community-intelligence/issues/20))의
   이관이 완료되어, §3.2 분류 결정 트리를 실제 문서 19건에 적용한
   결과가 나온다 — 이 과정에서 트리가 어긋나면 승격 전에 이 문서를
   먼저 고친다.
3. §5의 과도기 조항(수동 복사 절차)을 삭제한다.
