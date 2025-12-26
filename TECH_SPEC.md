# dotdot iOS - Technical Specification

**Created:** November 17, 2025  
**Last Updated:** December 24, 2025  
**Status:** Ready for Review

## 1. Project Overview

dotdot is a native iOS application that helps users track movies, TV shows, variety shows, and anime they've watched. Users can rate entries, add personal notes, mark items as currently watching, and maintain a viewing history organized by year.

### 1.1 Core Features

- User authentication (email/password)
- Dashboard view with entries grouped by year (2025, 2024, etc.)
- Add/Edit/Delete entries
- Rating system (1-3 dots: good, great, excellent)
- Mark items as "currently watching"
- Add personal notes to entries
- Search entries by title
- Offline support with local persistence
- Cloud sync across devices (optional for V1)

### 1.2 Target Platform

- **Minimum iOS Version:** iOS 17.0 (required for SwiftData)
- **Target Devices:** iPhone and iPad
- **Orientation:** Portrait (primary), Landscape (supported)
- **Language:** English only (V1)

## 2. Technical Architecture

### 2.1 Architecture Pattern: MVVM

The app follows the **Model-View-ViewModel** pattern with SwiftUI:

```
┌─────────────────────────────────────────────┐
│                   View                      │
│              (SwiftUI Views)                │
└─────────────────┬───────────────────────────┘
                  │ ObservedObject
                  │ Published properties
┌─────────────────▼───────────────────────────┐
│                ViewModel                    │
│          (ObservableObject)                 │
│    • Business logic                         │
│    • State management                       │
│    • Service coordination                   │
└─────────────────┬───────────────────────────┘
                  │ Calls
                  │
┌─────────────────▼───────────────────────────┐
│              Services                       │
│    • API Client                             │
│    • Local Storage                          │
│    • Authentication                         │
└─────────────────┬───────────────────────────┘
                  │ Uses
                  │
┌─────────────────▼───────────────────────────┐
│               Models                        │
│         (Data Structures)                   │
└─────────────────────────────────────────────┘
```

### 2.2 Project Structure

The project uses a **feature-based organization** where each feature contains its own View and ViewModel in a dedicated folder. This approach improves code discoverability and maintainability as the project grows.

```
dotdot/
├── Features/           # Feature-based modules
│   ├── Dashboard/      # Dashboard view + ViewModel
│   ├── EntryDetail/    # Entry detail view + ViewModel
│   ├── AddEntry/       # Add entry form view + ViewModel
│   ├── EditEntry/      # Edit entry form view + ViewModel
│   ├── Auth/           # Authentication views + ViewModels
│   └── Search/         # Search view + ViewModel
├── Core/               # Shared domain code
│   ├── Models/         # Shared domain models (Entry, User, EntryType)
│   └── Shared/         # Shared components and utilities
├── Services/           # API clients, storage, authentication services
├── Utilities/          # Extensions, helpers, constants
└── Resources/          # Fonts, localization files, assets
```

## 3. Data Models

### 3.1 Core Models

#### Entry (SwiftData Model)
```swift
@Model
final class Entry {
    @Attribute(.unique) var id: UUID
    var title: String
    var type: EntryType
    var rating: Int?
    var notes: String?
    var origin: Origin?
    var watching: Bool
    var createdAt: Date
    var updatedAt: Date

    var year: Int {
        Calendar.current.component(.year, from: createdAt)
    }
}
```

#### EntryDTO (API Transfer Object)
```swift
struct EntryDTO: Codable {
    let id: String
    let title: String
    let type: String
    let rating: Int?
    let notes: String?
    let origin: String?
    let watching: Bool
    let createdAt: Date
    let updatedAt: Date
}
```

**Model ↔ DTO Mapping:**
- `Entry` is used for local persistence (SwiftData)
- `EntryDTO` is used for API requests/responses (Codable)
- Service layer maps between them during sync
- `Entry.id` (UUID) ↔ `EntryDTO.id` (String) via `uuid.uuidString`

**Design Notes:**
- Each entry represents a viewing experience (watched or currently watching), tracked by when it was added to the list
- `userId` is not part of the iOS model - entries are automatically associated with the current authenticated user at the service/sync layer
- `origin` is optional - user can specify where the content is from via picker
- Year grouping uses `createdAt` date (when user added the entry)
- If a user rewatches content in a different year, it becomes a new entry
- Entries are grouped by year in the dashboard (e.g., "2025", "2024")

#### EntryType
```swift
enum EntryType: String, Codable, CaseIterable {
    case movie = "movie"
    case tvShow = "tv_show"
    case varietyShow = "variety_show"
    case anime = "anime"
}
```

#### Origin
```swift
enum Origin: String, Codable, CaseIterable {
    case usa, uk, korea, japan, china, taiwan, hongKong, thailand, india, france, spain, other
}
```

#### User
```swift
struct User: Identifiable, Codable {
    let id: String
    let email: String
    let createdAt: Date
}
```

### 3.2 Validation Rules

**Entry validation:**
- Title: Required, max 200 characters
- Type: Required (movie, tvShow, varietyShow, or anime)
- Rating: Optional when `watching = true`, required otherwise (1-3: good, great, excellent)
- Notes: Optional, max 1000 characters
- Origin: Optional, selected from predefined picker (see Origin enum)
- Watching: Boolean, defaults to false

### 3.3 Rating Transition Flow

When user marks an entry as "done watching" (`watching: true → false`):

1. **Trigger:** User taps "Mark as watched" or similar action
2. **Modal appears:** Rating picker sheet (1-3 dots: good, great, excellent)
3. **Required:** User must select a rating to proceed
4. **Cannot dismiss:** No "skip" option - rating is mandatory for completed entries
5. **On submit:** Entry updated with `watching = false` and selected rating

## 4. Design System

### 4.1 Color Palette

| Role | Color | Hex |
|------|-------|-----|
| Primary | Purple | #B794F4 |
| Background | Dark | #0a0a0a |
| Surface | Dark Gray | #1a1a1a |
| Border | White 10% | - |
| Text Primary | White | #ffffff |
| Text Secondary | Gray | #9ca3af |
| Error | Red | #ef4444 |
| Success | Green | #10b981 |

### 4.2 Typography

- System font (SF Pro) with Dynamic Type support
- Text hierarchy: Title, Headline, Body, Caption
- Button text: Semibold weight

### 4.3 Components

Reusable UI elements needed:
- **Buttons** - Primary, secondary, destructive variants
- **Cards** - Container for entry items
- **Rating picker** - 1-3 dot selector (good, great, excellent)
- **Text inputs** - Single-line and multi-line variants
- **Type picker** - Entry type selector
- **Search bar** - Search entries by title

### 4.4 Spacing

8pt grid system: 4 / 8 / 16 / 24 / 32

## 5. Tech Stack

### 5.1 Dependencies

**Planned (to be added as needed):**
- Supabase Swift SDK (backend integration)
- KeychainAccess (secure token storage)
- SwiftLint (code quality - already configured)

**No heavy third-party dependencies** - leveraging native iOS frameworks where possible.

### 5.2 Native Frameworks

- `SwiftUI` - UI framework
- `Combine` - Reactive programming
- `SwiftData` - Local persistence (lightweight migration for schema changes; complex migrations addressed as needed)
- `Foundation` - Core utilities
- `CryptoKit` - Encryption
- `AuthenticationServices` - Auth UI

## 6. Development Phases

### Phase 1: Foundation ✅
**Status:** In Progress
**Duration:** Week 1

- [x] GitHub repository setup
- [x] Xcode project initialization
- [x] Folder structure (feature-based)
- [x] SwiftLint configuration
- [x] Build configurations (Debug/Release)
- [x] CI pipeline (lint, build, test)
- [ ] Branch protection rules

### Phase 2: Core Architecture & Design System
**Duration:** Week 1-2

**Phase 2.1:** Data Models
- Create `Entry`, `EntryType`, `User` models
- Implement validation logic
- Add Codable conformance

**Phase 2.2:** Design System
- Define color palette in Assets.xcassets
- Create typography system
- Build reusable UI components (buttons, cards, inputs)

**Phase 2.3:** Navigation
- Set up NavigationStack
- Create routing structure
- Define screen flow

**Phase 2.4:** Architecture Design (Offline-First + Backend Sync)
- Design offline-first architecture pattern
- Define Service Layer responsibilities
- Design Repository + API Client interaction
- Design sync queue strategy
- Define conflict resolution approach
- Document data flow (SwiftData ↔ Backend)
- Get team approval on architecture design
- Create architecture documentation

### Phase 3: Dashboard & List Views
**Duration:** Week 2-3

- Build Dashboard screen UI with year-based grouping
- Create EntryListView component
- Implement EntryCardView
- Build EntryDetailView
- Create mock data for testing
- Implement search functionality by title

### Phase 4: CRUD Operations
**Duration:** Week 3-4

- Build AddEntryView with form validation
- Build EditEntryView
- Implement delete confirmation
- Add form validation with error messages
- Connect to local storage (SwiftData)
- Implement offline-first data flow

### Phase 5: Testing Foundation
**Duration:** Week 4

- Unit tests for models and validation
- Unit tests for view models
- UI tests for critical user flows
- Test coverage target: 70%+

### Phase 6: Landing & Authentication
**Duration:** Week 5-6

- Code signing setup (for TestFlight/device testing)
- Build landing/onboarding screens
- Create sign up flow
- Create login flow
- Implement email validation
- Add password requirements
- Build forgot password flow
- Set up TestFlight deployment pipeline (when ready for beta testing)

### Phase 7: Polish & Refinements
**Duration:** Week 6-7

- Add animations and transitions
- Implement accessibility features
- Add haptic feedback
- Error handling and retry logic
- Empty states and loading indicators
- Dark mode support (if not already)

### Phase 8: Backend Integration
**Duration:** Week 7-8

- Integrate Supabase Swift SDK
- Implement authentication with Supabase Auth
- Set up real-time sync (optional for V1)
- Migrate from local-only to sync model
- Handle conflict resolution
- Add retry and error handling

### Phase 9: App Store Preparation
**Duration:** Week 9

- App Store screenshots
- App Store description and metadata
- Privacy policy
- Terms of service
- Final testing and bug fixes
- TestFlight beta testing (deployment pipeline set up in Phase 6)
- App Store submission

## 7. Testing Strategy

- **Unit Tests:** Models, ViewModels, Services (70%+ coverage target)
- **UI Tests:** Critical flows (auth, CRUD, rating, search)
- **Tools:** XCTest, XCUITest, mock services

## 8. CI/CD Pipeline

**CI (implemented):** On every PR → lint, build, test

**CD (Phase 6-9):** TestFlight deployment deferred until features ready

**Environments:** Debug (mock data) → Staging (TestFlight) → Production (App Store)

## 9. Backend Integration (Supabase)

### 9.1 Supabase Services Used

- **Authentication:** Email/password auth
- **Database:** PostgreSQL for entries and user data
- **Real-time:** Live sync across devices
- **Storage:** Future: profile photos (if needed)

### 9.2 Database Schema

**entries table:**
```sql
id: uuid (primary key)
user_id: uuid (foreign key to auth.users)
title: text (max 200 chars)
type: text (enum: 'movie', 'tv_show', 'variety_show', 'anime')
rating: int (nullable, 1-3: good, great, excellent)
notes: text (nullable, max 1000 chars)
origin: text (nullable, enum: 'usa', 'uk', 'korea', 'japan', 'china', 'taiwan', 'hong_kong', 'thailand', 'india', 'france', 'spain', 'other')
watching: boolean (default false)
created_at: timestamptz (used for year grouping)
updated_at: timestamptz
```

**Note:** Entries are grouped by the year of `created_at` in the dashboard. No separate `watched_date` field is needed.

### 9.3 Sync Strategy

**Offline-First Approach:**
1. All operations work locally first (SwiftData)
2. Changes queued for sync when online
3. Background sync on network availability
4. Conflict resolution: last-write-wins with `updated_at` (silent, no user notification)

**User Association:**
- The iOS Entry model does not include `userId` (entries are implicitly associated with the current user)
- The service/sync layer automatically injects `userId` from the authenticated session when syncing to backend
- Backend schema requires `userId` for Row Level Security (RLS) to ensure users can only access their own entries

### 9.4 Security

- Row Level Security (RLS) on all tables - users only access own data
- HTTPS for all API communication
- JWT tokens stored in iOS Keychain (not UserDefaults)
- Local data encrypted at rest (iOS default)
- No sensitive data in logs

## 10. Scope Decisions

**V1 (MVP) Scope:**
- ✅ iPad support with optimized layouts
- ✅ Year-based entry grouping
- ✅ Search functionality
- ✅ Local-first offline support
- ✅ Optional cloud sync

**V2 (Future) Features:**
- Social features (sharing, friends)
- External API integration (TMDB, IMDB) for metadata
- Data export (CSV, JSON)
- Push notifications

