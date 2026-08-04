# Grafana Lab Product Backlog

## Product Goal

Build an automated observability platform that monitors an
Ubuntu server and displays useful information in Grafana.

## Definition of Done

A story is complete when:

- The work has been tested
- Documentation has been updated
- Changes have been committed to Git
- No known errors remain
- The acceptance criteria have been satisfied

## Backlog

### Story 1: Automated Health Check

As a system administrator,
I want an automated health-check script,
so that I can quickly review the server's condition.

Acceptance criteria:

- Displays system uptime
- Displays disk usage
- Displays memory usage
- Displays Grafana service status
- Runs without errors

Priority: High
Story points: 2
Status: Done

### Story 2: Save Health Reports

As a system administrator,
I want health-check results saved to a file,
so that I can review previous system conditions.

Acceptance criteria:

- Creates a reports directory
- Adds the date to each report
- Saves all health-check results
- Does not overwrite earlier reports

Priority: High
Story points: 3
Status: Done

### Story 3: Automated Testing

As a developer,
I want the health-check script tested automatically,
so that errors are detected before deployment.

Acceptance criteria:

- Confirms the script exists
- Confirms the script is executable
- Confirms the script produces output
- Reports whether the test passed or failed

Priority: High
Story points: 5
Status: Backlog

### Story 4: Grafana Dashboard

As an operations engineer,
I want a Grafana system dashboard,
so that I can monitor server health visually.

Acceptance criteria:

- Displays CPU usage
- Displays memory usage
- Displays disk usage
- Shows whether the server is available

Priority: Medium
Story points: 8
Status: Backlog

## Sprint 1

Sprint goal:

Create and save timestamped system health reports.

Selected story:

Story 2: Save Health Reports
