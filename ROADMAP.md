# Development Roadmap

---

## Phase 1: Foundation ✅

- [x] GitHub repository setup
- [x] Xcode project initialization
- [x] Folder structure (feature-based)
- [x] SwiftLint configuration
- [x] Build configurations (Debug/Release)
- [x] CI pipeline (lint, build, test)
- [ ] Branch protection rules

---

## Phase 2: Core Architecture & Design System ✅

### Phase 2.1: Data Models
- [x] Create `Entry`, `EntryType`, `User` models
- [x] Implement validation logic
- [x] Add Codable conformance

### Phase 2.2: Design System
- [x] Define color palette in Assets.xcassets
- [x] Create typography system
- [x] Build reusable UI components (buttons, cards, inputs)

---

## Phase 3: Dashboard & List Views

- [ ] Build Dashboard screen UI with year-based grouping
- [ ] Create EntryListView component
- [ ] Implement EntryCardView
- [ ] Build EntryDetailView
- [ ] Build AddEntryView with form validation
- [ ] Build EditEntryView
- [ ] Create mock data for testing
- [ ] Implement search functionality by title

---

## Phase 4: Authenticated Navigation

- [ ] Set up NavigationStack for main app
- [ ] Create routing structure
- [ ] Define screen flow

---

## Phase 5: CRUD Operations

- [ ] Implement delete confirmation
- [ ] Add form validation with error messages
- [ ] Connect to local storage (SwiftData)
- [ ] Implement offline-first data flow

---

## Phase 6: Testing Foundation

- [ ] Unit tests for models and validation
- [ ] Unit tests for view models
- [ ] UI tests for critical user flows
- [ ] Test coverage target: 70%+

---

## Phase 7: Landing & Authentication

- [ ] Build landing screen
- [ ] Build onboarding screens
- [ ] Create sign up flow
- [ ] Create login flow
- [ ] Implement email validation
- [ ] Add password requirements
- [ ] Build forgot password flow
- [ ] Implement root navigation (auth/unauth flow switching)

---

## Phase 8: Polish & Refinements

- [ ] Add animations and transitions
- [ ] Implement accessibility features
- [ ] Add haptic feedback
- [ ] Error handling and retry logic
- [ ] Empty states and loading indicators
- [ ] Dark mode support (if not already)

---

## Phase 9: Architecture Design (Offline-First + Backend Sync)

- [ ] Design offline-first architecture pattern
- [ ] Define Service Layer responsibilities
- [ ] Design Repository + API Client interaction
- [ ] Design sync queue strategy
- [ ] Define conflict resolution approach
- [ ] Document data flow (SwiftData ↔ Backend)
- [ ] Get team approval on architecture design
- [ ] Create architecture documentation

---

## Phase 10: Backend Integration

- [ ] Integrate Supabase Swift SDK
- [ ] Implement authentication with Supabase Auth
- [ ] Implement EntryService (orchestrates Repository + API Client)
- [ ] Implement EntryAPIClient (network requests)
- [ ] Implement sync queue management
- [ ] Set up real-time sync (optional for V1)
- [ ] Handle conflict resolution
- [ ] Add retry and error handling
- [ ] Entry ↔ EntryDTO mapping

---

## Phase 11: App Store Preparation

- [ ] Code signing setup
- [ ] Set up TestFlight deployment pipeline
- [ ] App Store screenshots
- [ ] App Store description and metadata
- [ ] Privacy policy
- [ ] Terms of service
- [ ] Final testing and bug fixes
- [ ] TestFlight beta testing
- [ ] App Store submission

---
