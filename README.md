# Git hooks
A set of git hook scripts to make commits more structured

[**Deck board**](https://github.com/hoss-java/githooks/blob/main/DECK.md)

## What git-hooks are
Git-hooks are a set of scripts that check commit messages to be sure they follow a structure that can be tracked via a document file.

The description written about a commit can always include a link to the commit itself. But from the commit side, it is not possible to access the documented explanation about the commit. GitHooks essentially make the connection between the documentation and the commit itself two-ways by assigning a reference number to the commit. They also add a link to comments to provide access to documents parts directly from the commit.

## How it works
Git hooks check all commit messages to be sure messages start with a pattern like [W<week-number>-C<card-number>].
It means that a commit command with activated git hooks should be look like below. If a commit message is not started with the pattern, hook scripts shows an error and ask to use a valid pattern. 

```
git commit -m "[W47-001] commit message/description"
```

A format commit message is processed by by the git hooks to create a link to a related document (a markdown file) and adding link to commit.
Given that a task management system (such as Deck) is not available in the free version of GitHub, a Markdown file has been used instead to manage stories/commits. In other words a markdown file is defined for the git hooks and the hooks add a link to a tag (based on commit parssed message) in the markdown file to the commit.

As an example to understand how it works, assume the link to the Markdown file is https://github.com/hoss-java/lessons/blob/main/DECK.md. Using [w47-001] as the prefix for a commit message, add https://github.com/hoss-java/lessons/blob/main/DECK.md#47-001 as the reference link in the commit. It means the link tries to find `47-001` as a tag in `DECK.md`

* DECK.md
>```
>.
>.
>## 47-001
> Task description and explanation
>.
>.
>```

## How to install and activating git hooks
This repository contains 6 files and a readme and a DECK sample file
> * `commit-msg`
> * `commit-msg-decklink.shinc`
> * `commit-msg-format.shinc`
> * `deckpath.shinc`
> * `msg-check.sh`
> * `pre-commit`

1. Clone the repo
2. Copy all files above to `.git/hooks` , in side of repositories that you want use git hooks
3. Upen `.git/hooks/deckpath.shinc` and update the path of the deck file (`deckAddr`).
>```
>#
># File name : deckpath.shinc
># Used by commit-msg
>#
># Description :
># -----------------------------------------------------
># Define the deck file path
>#
># The script is developed to run from commit-msg as a git hook.
>#
>#
># 2025 hossjava@osxx.com
>
>deckAddr=https://github.com/hoss-java/lessons/blob/main/DECK.md
>```
4. Create or add a file to the repo in the same address that you define in `.git/hooks/deckpath.shinc`
5. For each commit add a section with a title that follows hook message pattern.
> `https://github.com/hoss-java/lessons/blob/main/DECK.md`
>>```
>>.
>>.
>># Commit 'message 1' with a commit message ´[w47-001] message 1´
>>## 47-001
>>.
>>.
>>
>># Commit 'message 2' with a commit message ´[w47-002] message 2´
>>## 47-002
>>.
>>.
>>```
6 . Use `DECK.md.sample` as a sample for `DECK.md`
7. To access to the link added by git hooks script, under commit destcription (click on the three dots `...` in the right site of the commit title) looks for `Deck-Link`)

# Git-Deck

The **Git-Deck** is a powerful tool designed to manage your Kanban boards directly through Git. With features that allow you to create, edit, and manage boards, columns, and cards, it integrates seamlessly with your existing workflow.

## Purpose
The Git-Deck allows you to perform various operations related to Kanban boards, making it easier to track tasks and manage projects efficiently. 

## Register git-deck
Before starting to use the deck command, it needs to be registered as a Git command.

```bash
git config alias.deck '!bash .git/hooks/git-deck/deck'
```

## Commands Overview

### Board Commands
- **Help**: `git deck board help`
- **List**: `git deck board ls`
- **Create**: `git deck board mk <board-name>`
- **Set**: `git deck board set <board-name>`
- **Remove**: `git deck board rm <board-name>`
- **Cleanup**: `git deck board cleanup`

### Column Commands
- **Help**: `git deck column help`
- **List**: `git deck column ls`
- **Create**: `git deck column mk <column-name>`
- **Set**: `git deck column set <column-name>`
- **Status**: `git deck column status <column-name>`
- **Remove**: `git deck column rm <column-name>`
- **Cleanup**: `git deck column cleanup`

### Card Commands
- **Help**: `git deck card help`
- **List**: `git deck card ls`
- **Find**: `git deck card find <card-name>`
- **Create**: `git deck card mk <card-name>`
- **Edit**: `git deck card edit <card-name>`
- **View**: `git deck card cat <card-name>`
- **Set**: `git deck card set <card-name>`
- **Move**: `git deck card mv <card-name> <column-name>`
- **Remove**: `git deck card rm <card-name>`
- **Cleanup**: `git deck card cleanup`

### Project Management Command
- **Command**: `git deck pm`

## Usage
To access the Git Deck commands, use the following syntax:

```bash
git deck {<command>|help}
```

# Git-Deck Kanban board manager

## Overview
The `pm` function manages project management features within a Git repository. It initializes a project management structure, allows for editing, and creates a deck of cards. This command supports various subcommands, including help, initialization, and management.

## Function Usage

### Command Format
`git deck pm {help|initpm|editpm|initdeck|createdeck}`


### Subcommands

#### 1. `help`
Displays the content of the project management help file.
- **Usage**: `git deck pm help`

#### 2. `initpm`
Initializes the project management files and directories.
- **Usage**: `git deck pm initpm`
- **Options**:
  - `-t <template>`: Specifies the template to use for initialization (default is 'default').

#### 3. `editpm`
Edits the project management markdown file using a specified editor.
- **Usage**: `git deck pm editpm`
- **Options**:
  - `-e <editor>`: Specifies the editor to use (default is `nano`).

#### 4. `initdeck`
Initializes the deck directory if it does not already exist.
- **Usage**: `git deck pm initdeck`

#### 5. `createdeck`
Creates or updates the `DECK.md` file based on the existing cards and boards.
- **Usage**: `git deck pm createdeck`

---

## Detailed Behavior

### Initializing Project Management
When `initpm` is called, the function checks if the `.pm` directory already exists. If it doesn't, it creates the directory and copies the specified template file into it. If it already exists, an informative message is printed.

### Editing Project Management
The `editpm` command opens the `pm.md` file in the specified editor (or default editor if not specified). If the file does not exist yet, an error message will be displayed.

### Initializing Deck
The `initdeck` command initializes the deck directory. If it already exists, a message indicating that it is already initialized will be shown.

### Creating the Deck File
The `createdeck` function compiles information from each board, column, and card into a `DECK.md` file formatted as Markdown. It extracts headers and other metadata from the cards, organizes them, and writes to the output file.

---

## Getting Help
If at any point you need assistance, you can display this help file by running: `git deck pm help`

# Git-Deck Bash Autocompletion Help File

## Overview
The `git deck` command provides a structured way to manage project boards, columns, and cards within a Git repository. This script enables autocompletion for various subcommands and options.

## Commands

### 1. Base Command: `git deck`
This command supports the following first-level commands:
- **pm**: Project management commands.
- **board**: Manage project boards.
- **column**: Manage columns within boards.
- **card**: Manage cards within columns.
- **help**: Display help information.

---

### 2. Project Management Commands (`git deck pm`)
- **help**: Displays help for project management.
- **initpm**: Initializes the project management setup.
- **editpm**: Edits project management details.
- **initdeck**: Initializes a new deck.
- **createdeck**: Creates a new deck.

---

### 3. Board Commands (`git deck board`)
- **help**: Displays help for boards.
- **ls**: Lists existing boards.
- **mk**: Creates a new board.
- **rm**: Removes a board.
- **set**: Configures settings for a specific board.
- **cleanup**: Cleans up unused boards.

**Autocompletion**:
  - For `mk`, existing templates are suggested.
  - For `rm`, existing boards and options like `--remove` are suggested.

---

### 4. Column Commands (`git deck column`)
- **help**: Displays help for columns.
- **ls**: Lists existing columns.
- **mk**: Creates a new column.
- **set**: Configures specific column settings.
- **status**: Checks status of a column.
- **rm**: Removes a column.
- **cleanup**: Cleans up unused columns.

**Autocompletion**:
  - For `set`, existing columns are suggested.
  - For `rm`, existing columns and options like `--remove` are suggested.

---

### 5. Card Commands (`git deck card`)
- **help**: Displays help for cards.
- **ls**: Lists existing cards.
- **find**: Searches for a specific card.
- **mk**: Creates a new card.
- **edit**: Edits an existing card.
- **cat**: Displays details of a card.
- **set**: Updates card properties.
- **mv**: Moves a card to a different column.
- **rm**: Removes a card.
- **cleanup**: Cleans up unused cards.

**Autocompletion**:
  - For `edit`, `cat`, and `set`, existing cards are suggested.
  - For `rm`, existing cards and options like `--remove` are suggested.
  - For `mv`, both existing cards and columns are suggested.

---

## Installation
To install, copy this script into your Bash configuration file (e.g., `.bashrc` or `.bash_profile`). Ensure the script is registered for autocompletion with:

```bash
source git-deck-completion.sh
```

# Github API

## Goal
The goal of this spike is to demonstrate how to use the GitHub API to synchronize tasks between Git-Deck boards and GitHub Kanban boards.

## Findings

* GitHub supports a REST API that can be used in both GitHub Actions and external automations.
* To connect to the GitHub API, it needs to create an authorization token.
> * A token can be created via `https://github.com/settings/apps`
> * Github offers two types of token, **Fine-grained tokens** and **Classic token**
> * A **Classic token** lets to select almost all available permissions
> * Usually, tokens used with GitHub Actions are fine-grained tokens. Most permissions can be restricted or configured through the Action's YAML workflow file.
> * Tokens used for remote connections often require additional permissions that fine-grained tokens don't provide. In those cases, a classic token is a better choice.
> * Once a token is created, it should be copied and stored somewhere safe. To use a token in a GitHub automation, it needs to create a new secret value for each repository using that token (TAP).
> * **OBS!** Tokens can authenticate clients with GitHub, but they are not always required. For interactive use, signing in with a username/password or web-based authorization (OAuth) is often simpler than managing tokens. Tokens are primarily used for programmatic access to the GitHub API.
> * **OBS!** It seems that GitHub has imposed a major structural change on its API. They moved from a classic API to a GraphQL API. The classic API was deprecated in April 2025 and is no longer available, but much of the documentation still references the classic API. In other words, almost all GitHub API documentation is now outdated or unusable. However, the GitHub token creator has not been updated yet, and many settings do nothing or do not affect functionality.

* To create an actions secrets: go to Repository settings → Actions → Secrets and variables, then create a repository secret(`https://github.com/USER/REPO/settings/secrets/actions`).
> * Once a secret is created, it asks you to choose a name and paste a token created through `https://github.com/settings/apps`.
> * The name used for a secret can be referenced later in Actions workflows.

* The GitHub API can be accessed via languages such as JavaScript or Python, or via the `gh` command or `curl`. For sh/bash scripts used to manage actions or automate jobs, `curl` is more useful.
> * The new GitHub API uses `https://api.github.com/graphql` as the endpoint. All other endpoints mentioned in GitHub documents — and even help or hints returned when calling an API command via the new endpoint — are invalid.
> * It seems GitHub planned to fully implement the new GraphQL-based API (GraphQL 2024) and then deprecate the old/classic REST API during 2025, but the new API was not fully ready. The migration did not go according to plan: many features still don’t work, yet the classic API was retired as scheduled!!
> * However, the old API no longer works and the new one has not been fully implemented yet. Documentation has not been updated, so there is no reliable source for how to use the new API. The new GraphQL API also returns many incorrect responses and error messages that reference the old REST API and outdated documentation.
> * A new API call looks like below (the example below lists all projects on a repo):
>>```
>>curl -s -H "Authorization: bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{"query":"query($owner:String!, $name:String!){ repository(owner:$owner, name:$name){ projectsV2(first:100){ nodes{ id number title shortDescription } } } }","variables":{"owner":"OWNER","name":"REPO"}}'
>>```

* Development of a script to sync Git-Deck and GitHub Kanban boards could not be finished because many functionalities were removed or not implemented in the new GitHub API.
> * A sync tool needs the following functionalities: create/list/read projects; add/list/modify views; create/list/modify boards; and add/remove/read/modify columns and cards.
> * The new GitHub API has no service to modify boards or to add, remove, read, or modify columns and cards, which are required to develop a sync tool.
> * However, it was not possible to develop the planned sync tool but while working around the GitHub API, some solutions were found to use other API parts which are implemented now but are not documented by GitHub.
> * Here are some GitHub API endpoints and approaches discovered while working around the new GraphQL API 
>>```bash
>> # list all projects on a repo
>> curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"query($owner:  String!, $name:String!) { repository(owner:$owner, name:$name) { projectsV2(first: 10) { nodes { id number title } } } }",
>>       "variables":{"owner":"OWNER","name":"REPO"}
>>     }' | jq .
>>``` 
>>>```json
>>># output something like below
>>>{
>>>  "data": {
>>>    "repository": {
>>>      "projectsV2": {
>>>        "nodes": [
>>>          {
>>>            "id": "PVT_...",
>>>            "number": 01,
>>>            "title": "My Project"
>>>          }
>>>        ]
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>>```bash
>># list all view in a project repo
>>curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"query($owner: String!, $name:String!, $number: Int!) { repository(owner:$owner, name:$name) { projectV2(number:$number) { id title views(first: 100) { nodes { id name layout } } } } }",
>>       "variables":{"owner":"OWNER","name":"REPO","number": PROJECT_NUMBER}
>>     }' | jq .
>>```
>>>```json
>>> # output something like below
>>>{
>>>  "data": {
>>>    "repository": {
>>>      "projectV2": {
>>>        "id": "PVT_...",
>>>        "title": "My Project",
>>>        "views": {
>>>          "nodes": [
>>>            {
>>>              "id": "PVTV_...",
>>>              "name": "View 1",
>>>              "layout": "TABLE_LAYOUT"
>>>            },
>>>            {
>>>              "id": "PVTV_...",
>>>              "name": "Kanban Board",
>>>              "layout": "BOARD_LAYOUT"
>>>            },
>>>          ]
>>>        }
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>>```bash
>># Get repository and its owner IDs
>>curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"query($owner: String!, $name:String!) { repository(owner:$owner, name:$name) { id owner { id } } }",
>>       "variables":{"owner":"OWNER","name":"REPO"}
>>     }' | jq .
>>```
>>>```json
>>># Output
>>>{
>>>  "data": {
>>>    "repository": {
>>>      "id": "*REPOSITORYID",
>>>      "owner": {
>>>        "id": "OWNERID"
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>>```bash
>># Create Project with repository and its owner IDs
>>curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type:  application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"mutation($ownerId: ID!, $repositoryId: ID!, $title: String!) { createProjectV2(input: {ownerId:  $ownerId, repositoryId: $repositoryId, title:  $title}) { projectV2 { id title number } } }",
>>       "variables":{"ownerId":"OWNERID","repositoryId":"REPOSITORYID","title":"My Project"}
>>     }' | jq .
>>```
>>>```json
>>># Output
>>>{
>>>  "data": {
>>>    "createProjectV2": {
>>>      "projectV2": {
>>>        "id": "PVT_...",
>>>        "title": "My Project",
>>>        "number": 12
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>>```bash
>># Create/add files to use later within board as columns' type
>># named 'Workflow' with 5 sub fields "To Do", "In Progress", "In Review", "Testing" and "Done"
>>curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"mutation($projectId: ID!, $name: String!, $dataType: ProjectV2CustomFieldType!, $options: [ProjectV2SingleSelectFieldOptionInput!]!) { createProjectV2Field(input: {projectId:  $projectId, name: $name, dataType: $dataType, singleSelectOptions: $options}) { projectV2Field { ... on ProjectV2SingleSelectField { id name options { id name color description } } } } }",
>>       "variables":  {
>>         "projectId":"PVT_...",
>>         "name":"Workflow",
>>         "dataType":"SINGLE_SELECT",
>>         "options": [
>>           {"name":"To Do","color":"GRAY","description":"Task not started"},
>>           {"name":"In Progress","color":"BLUE","description":"Currently working"},
>>           {"name":"In Review","color":"YELLOW","description":"Waiting for review"},
>>           {"name":"Testing","color":"PURPLE","description":"In testing phase"},
>>           {"name":"Done","color":"GREEN","description":"Completed"}
>>         ]
>>       }
>>     }' | jq .
>>```
>>>```json
>>># Output
>>>{
>>>  "data": {
>>>    "createProjectV2Field": {
>>>      "projectV2Field": {
>>>        "id": "PVTSSF_...",
>>>        "name": "Workflow",
>>>        "options": [
>>>          {
>>>            "id": "e04df16f",
>>>            "name": "To Do",
>>>            "color": "GRAY",
>>>            "description": "Task not started"
>>>          },
>>>          {
>>>            "id": "3717fc77",
>>>            "name": "In Progress",
>>>            "color": "BLUE",
>>>            "description": "Currently working"
>>>          },
>>>          {
>>>            "id": "d5fed953",
>>>            "name": "In Review",
>>>            "color": "YELLOW",
>>>            "description": "Waiting for review"
>>>          },
>>>          {
>>>            "id": "b3140331",
>>>            "name": "Testing",
>>>            "color": "PURPLE",
>>>            "description": "In testing phase"
>>>          },
>>>          {
>>>            "id": "b07ae633",
>>>            "name": "Done",
>>>            "color": "GREEN",
>>>            "description": "Completed"
>>>          }
>>>        ]
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>> * **OBS!** It's also possible to perform all API requests via the GitHub CLI (gh). For example :
>>>```bash
>>> gh project field-create 10 --owner OWNER --name "Workflow" --data-type "SINGLE_SELECT" --single-select-options "To Do,In Progress,In Review,Testing,Done"
>>>```
>>```bash
>># Verify added fields
>>curl -H "Authorization: Bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>       "query":"query($projectId: ID!) { node(id: $projectId) { ... on ProjectV2 { id title fields(first: 20) { nodes { ... on ProjectV2Field { id name } ... on ProjectV2SingleSelectField { id name options { id name } } } } } } }",
>>       "variables": {"projectId":"PROJECT_ID"}
>>     }'
>>```
>>>```json
>>># Output
>>>{
>>>  "data": {
>>>    "node": {
>>>      "id": "PVT_...",
>>>      "title": "My Project",
>>>      "fields": {
>>>        "nodes": [
>>>          {
>>>            "id": "PVTF_...",
>>>            "name": "Title"
>>>          },
>>>          {
>>>            "id": "PVTF_...",
>>>            "name": "Assignees"
>>>          },
>>>          {
>>>            "id": "PVTSSF_...",
>>>            "name": "Status",
>>>            "options": [
>>>            .
>>>            .
>>>            .
>>>            ]
>>>          },
>>>          .
>>>          .
>>>          .
>>>          {
>>>            "id": "PVTSSF_...",
>>>            "name": "Workflow",
>>>            "options": [
>>>              {
>>>                "id": "e04df16f",
>>>                "name": "To Do"
>>>              },
>>>              .
>>>              .
>>>              .
>>>            ]
>>>          }
>>>        ]
>>>      }
>>>    }
>>>  }
>>>}
>>>```
>>```bash
>># Get a list of all supported mutations ( Here can see there is no supports for needed services such as add/modify columns)
>>curl -s -H "Authorization: Bearer $GITHUB_TOKEN" -H "Content-Type: application/json" \
>>  -X POST https://api.github.com/graphql \
>>  -d '{"query":"{ __schema { mutationType { fields { name description } } } }"}'
>>```
>>>```json
>>># Output
>>>{
>>>  "data": {
>>>    "__schema": {
>>>      "mutationType": {
>>>        "fields": [
>>>          {
>>>            "name": "abortQueuedMigrations",
>>>            "description": "Clear all of a customer's queued migrations"
>>>          },
>>>          {
>>>            "name": "abortRepositoryMigration",
>>>            "description": "Abort a repository migration queued or in progress."
>>>          },
>>>          {
>>>            "name": "acceptEnterpriseAdministratorInvitation",
>>>            "description": "Accepts a pending invitation for a user to become an administrator of an enterprise."
>>>          },
>>>          .
>>>          .
>>>          .
>>>          {
>>>            "name": "updateRefs",
>>>            "description": "Creates, updates and/or deletes multiple refs in a repository.\n\nThis mutation takes a list of `RefUpdate`s and performs these updates\non the repository. All updates are performed atomically, meaning that\nif one of them is rejected, no other ref will be modified.\n\n`RefUpdate.beforeOid` specifies that the given reference needs to point\nto the given value before performing any updates. A value of\n`0000000000000000000000000000000000000000` can be used to verify that\nthe references should not exist.\n\n`RefUpdate.afterOid` specifies the value that the given reference\nwill point to after performing all updates. A value of\n`0000000000000000000000000000000000000000` can be used to delete a\nreference.\n\nIf `RefUpdate.force` is set to `true`, a non-fast-forward updates\nfor the given reference will be allowed.\n"
>>>          },
>>>          .
>>>          .
>>>          .
>>>          {
>>>            "name": "updateUserListsForItem",
>>>            "description": "Updates which of the viewer's lists an item belongs to"
>>>          },
>>>          {
>>>            "name": "verifyVerifiableDomain",
>>>            "description": "Verify that a verifiable domain has the expected DNS record."
>>>          }
>>>        ]
>>>      }
>>>    }
>>>  }
>>>}
>>>```
 Other findings
> * The new GitHub API accepts GraphQL query language statements as parameters. For example, the command below passes the query and variables separately using the "query" and "variables" fields in the JSON payload:
>>```bash
>>curl -s -H "Authorization: bearer $GITHUB_TOKEN" \
>>     -H "Content-Type: application/json" \
>>     -X POST https://api.github.com/graphql \
>>     -d '{
>>     	"query":"query($owner:String!, $name:String!){ repository(owner:$owner, name:$name){ projectsV2(first:100){ nodes{ id number title shortDescription } } } }",
>>     	"variables":{"owner":"OWNER","name":"REPO"}
>>     }'
>>```
> * `jq` supports passing variables as arg
>>```bash
>>.
>>.
>>local org_name="$1"
>>local paginationBoundaries=$3
>>data=$(jq -n \
>>  --arg orgName "$org_name" \
>>  --arg paginationBoundaries "$pagination_boundaries" \
>>  '{
>>    "query": "{
>>      user(login: \($orgName | @json)) {
>>        projectsV2(first: \($paginationBoundaries)) {
>>          nodes {
>>            id
>>            title
>>            number
>>            repositories(first: \($paginationBoundaries)) {nodes {name} }
>>          }
>>        }
>>      }
>>    }"
>>  }')
>> 
>>response=$(curl -s --request POST \
>>    --url https://api.github.com/graphql \
>>    --header "Authorization: Bearer $token" \
>>    --data "$data")
>>.
>>.
>>
>>```
>> * **OBS!** In `jq`, `\($orgName | @json)` inside a double-quoted string inserts the JSON-encoded value of $orgName, with quotes escaped so the result is a valid JSON string.
>>> *  $orgName — the jq variable.
>>> * `| @json` — encodes the value as JSON (adds surrounding quotes and escapes special chars).
>>> * `\(...)` — string interpolation inside jq double-quoted strings.

* Other code written before realizing parts of the GitHub API were missing:
>```bash
>#!/bin/sh
>token=$GITHUB_TOKEN
>pagination_boundaries=20
>
># Function to github project data structure
>get_project_structure(){
>    data=$(jq -n \
>      '{
>        "query": "{
>          __type(name: \"ProjectV2\") {
>            name
>            fields {
>              name
>              type {
>                name
>                kind
>                ofType {
>                  name
>                }
>              }
>            }
>          }
>        }"
>      }')
>
>    response=$(curl -s --request POST \
>        --url https://api.github.com/graphql \
>        --header "Authorization: Bearer $token" \
>        --data "$data")
>
>    echo "$response"
>}
>
># Function to find github node id
>get_nodeid(){
>    response=$(curl -s --request GET \
>        --url https://api.github.com/users/hoss-java \
>        --header "Authorization: token $token" \
>        --header "Accept: application/vnd.github+json")
>
>    # Extract the node_id using jq
>    node_id=$(echo "$response" | jq  -r '.node_id')
>    if [ -z "$node_id" ] || [ "$node_id" = "null" ]; then
>        echo "failed to get nodeId"
>        echo "$response" | jq .
>        return 1
>    fi
>    echo "$node_id"
>    return 0
>}
>
># Function to search github repo for project id
>get_projectnumber_byname(){
>    local org_name="$1"
>    local title="$2"
>    local paginationBoundaries=$3
>    data=$(jq -n \
>      --arg orgName "$org_name" \
>      --arg paginationBoundaries "$pagination_boundaries" \
>      '{
>        "query": "{
>          user(login: \($orgName | @json)) {
>            projectsV2(first: \($paginationBoundaries)) {
>              nodes {
>                id
>                title
>                number
>                repositories(first: \($paginationBoundaries)) {nodes {name} }
>              }
>            }
>          }
>        }"
>      }')
>
>    response=$(curl -s --request POST \
>        --url https://api.github.com/graphql \
>        --header "Authorization: Bearer $token" \
>        --data "$data")
>
>    # Check if the title exists and extract the ID
>    #echo "$response"
>    project_number=$(echo "$response" | \
>        jq -r --arg title "$title" '.data.user.projectsV2.nodes[] | select(.title == $title) | .number'  | head -n 1)
>    if [ -n "$project_number" ]; then
>        echo "$project_number"
>        return 0
>    fi
>    echo "$response"
>    return 1
>}
>
># Function to search github repo for project id
>get_projectid_byrepo(){
>    local org_name="$1"
>    local repo_name="$2"
>    local paginationBoundaries=$3
>    data=$(jq -n \
>      --arg orgName "$org_name" \
>      --arg paginationBoundaries "$pagination_boundaries" \
>      '{
>        "query": "{
>          user(login: \($orgName | @json)) {
>            projectsV2(first: \($paginationBoundaries)) {
>              nodes {
>                id
>                title
>                number
>                repositories(first: \($paginationBoundaries)) {nodes {name} }
>              }
>            }
>          }
>        }"
>      }')
>
>    response=$(curl -s --request POST \
>        --url https://api.github.com/graphql \
>        --header "Authorization: Bearer $token" \
>        --data "$data")
>
>    # Check if the title exists and extract the ID
>    project_id=$(echo "$response" | \
>        jq -r --arg repo_name "$repo_name" '.data.user.projectsV2.nodes[] | select(.repositories.nodes[]?.name == $repo_name) | .id')
>    if [ -n "$project_id" ]; then
>        echo "$project_id"
>        return 0
>    fi
>    return 1
>}
>
># Function to create github repo project
>create_repoproject(){
>    local node_id="$1"
>    local repo_name="$2"
>    data=$(jq -n \
>        --arg ownerId "$node_id" \
>        --arg title "$repo_name" \
>        '{
>          "query": "mutation {
>            createProjectV2(input: {
>                ownerId: \($ownerId | @json),
>                title: \($title | @json),
>            }) {
>                projectV2 {
>                    id
>                }
>            }
>        }"
>    }')
>
>    response=$(curl -s --request POST \
>        --url https://api.github.com/graphql \
>        --header "Authorization: token $token" \
>        --data "$data")
>
>    # Extract the project_id using jq
>    project_id=$(echo "$response" | jq -r '.data.createProjectV2.projectV2.id')
>    if [ -z "$project_id" ] || [ "$project_id" = "null" ]; then
>        echo "failed to create a project"
>        echo "$response"
>        return 1
>    fi
>    echo "$project_id"
>    return 0
>}
>
># Main
>org_name=$OWNER
>repo_name=$REPO
>
>#response=$(get_project_structure)
>#echo "$response" | jq .
>#project_number=$(get_projectnumber_byname "$org_name" "$repo_name" 20)
>#echo "$project_number"
>
>#response=$(create_board "$org_name")
>response=$(get_board "$org_name")
>echo "$response" | jq .
>
>exit 1
>```

 References
> * https://docs.github.com/en/rest/projects/items?apiVersion=2022-11-28
> * https://github.blog/changelog/2025-09-23-upcoming-changes-to-github-dependabot-alerts-rest-api-offset-based-pagination-parameters-page-first-and-last/


