# dotdot iOS - Technical Specification

**Version:** 1.0
**Date:** November 2025
**Status:** Draft for Review

## 1. Project Overview

dotdot is a native iOS application that helps users track movies and TV shows they've watched. Users can rate content, add notes, mark items as currently watching, and maintain a personal viewing history.

### 1.1 Core Features

- User authentication (email/password)
- Dashboard view with all watched entries
- Add/Edit/Delete watched entries
- Rating system (1-3 dots: bad, okay, excellent)
- Mark items as "currently watching"
- Add personal notes to entries
- Filter and sort entries
- Offline support with local persistence
- Cloud sync across devices

### 1.2 Target Platform

- **Minimum iOS Version:** iOS 16.0
- **Target Devices:** iPhone and iPad
- **Orientation:** Portrait (primary), Landscape (supported)

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

```
dotdot/
├── Models/              # Data models and business entities
├── Views/              # SwiftUI views and UI components
├── ViewModels/         # ObservableObject view models
├── Services/           # API clients, storage, auth
├── Utilities/          # Extensions, helpers, constants
└── Resources/          # Fonts, localization files
```

## 3. Data Models

### 3.1 Core Models

#### WatchedEntry
```swift
struct WatchedEntry: Identifiable, Codable {
    let id: String
    let userId: String
    let title: String
    let type: EntryType
    var rating: Int?              // 1-3 (bad, okay, excellent)
    let watchedDate: Date
    var notes: String?
    var watching: Bool            // Currently watching flag
    let createdAt: Date
    var updatedAt: Date
}
```

#### EntryType
```swift
enum EntryType: String, Codable, CaseIterable {
    case movie = "movie"
    case tvShow = "tv_show"

    var displayName: String {
        switch self {
        case .movie: return "Movie"
        case .tvShow: return "TV Show"
        }
    }
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

**WatchedEntry validation:**
- Title: Required, max 200 characters
- Type: Required (movie or tv_show)
- Rating: Optional when `watching = true`, required otherwise (1-3)
- Watched Date: Required, cannot be in the future
- Notes: Optional, max 1000 characters
- Watching: Boolean, defaults to false

## 4. Design System

### 4.1 Color Palette

```swift
// Primary Colors
- Primary: Purple (#B794F4 / HSL 272° 91% 72%)
- Background: Dark (#0a0a0a)
- Surface: Dark Gray (#1a1a1a)

// UI Colors
- Border: White 10% opacity
- Text Primary: White (#ffffff)
- Text Secondary: Gray (#9ca3af)
- Error: Red (#ef4444)
- Success: Green (#10b981)
```

### 4.2 Typography

Using SF Pro (iOS system font) with the following scale:

- **Title**: 28pt Bold
- **Headline**: 20pt Semibold
- **Body**: 17pt Regular
- **Caption**: 13pt Regular
- **Button**: 17pt Semibold

### 4.3 Components

#### Reusable UI Components
- `DotButton` - Primary, secondary, destructive variants
- `DotCard` - Container for entry items
- `RatingPicker` - 1-3 dot selector
- `DotTextField` - Styled text input
- `DotTextEditor` - Multi-line text input
- `DotDatePicker` - Date selection
- `EntryTypePicker` - Movie/TV show selector

### 4.4 Spacing System

Based on 8pt grid:
- `xs`: 4pt
- `sm`: 8pt
- `md`: 16pt
- `lg`: 24pt
- `xl`: 32pt

## 5. Tech Stack

### 5.1 Core Technologies

- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI
- **Minimum iOS:** 16.0
- **Architecture:** MVVM

### 5.2 Dependencies

**Planned (to be added as needed):**
- Supabase Swift SDK (backend integration)
- KeychainAccess (secure token storage)
- SwiftLint (code quality - already configured)

**No heavy third-party dependencies** - leveraging native iOS frameworks where possible.

### 5.3 Native Frameworks

- `SwiftUI` - UI framework
- `Combine` - Reactive programming
- `CoreData` - Local persistence
- `Foundation` - Core utilities
- `CryptoKit` - Encryption
- `AuthenticationServices` - Auth UI

## 6. Development Phases

### Phase 1: Foundation ✅
**Status:** In Progress
**Duration:** Week 1

- [x] GitHub repository setup
- [x] Xcode project initialization
- [x] Folder structure (MVVM)
- [x] SwiftLint configuration
- [x] Build configurations (Debug/Release)
- [ ] Branch protection rules
- [ ] Code signing setup

### Phase 2: Core Architecture & Design System
**Duration:** Week 1-2

**Phase 2.1:** Data Models
- Create `WatchedEntry`, `EntryType`, `User` models
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

### Phase 3: Dashboard & List Views
**Duration:** Week 2-3

- Build Dashboard screen UI
- Create EntryListView component
- Implement EntryCardView
- Build EntryDetailView
- Create mock data for testing
- Implement list filtering and sorting

### Phase 4: CRUD Operations
**Duration:** Week 3-4

- Build AddEntryView with form validation
- Build EditEntryView
- Implement delete confirmation
- Add form validation with error messages
- Connect to local storage (CoreData)
- Implement offline-first data flow

### Phase 5: Testing Foundation
**Duration:** Week 4

- Unit tests for models and validation
- Unit tests for view models
- UI tests for critical user flows
- Test coverage target: 70%+

### Phase 6: CI/CD Pipeline
**Duration:** Week 4-5

- Set up GitHub Actions workflow
- Automated build on PR
- Automated test execution
- TestFlight deployment automation
- Configure build versioning

### Phase 7: Landing & Authentication
**Duration:** Week 5-6

- Build landing/onboarding screens
- Create sign up flow
- Create login flow
- Implement email validation
- Add password requirements
- Build forgot password flow

### Phase 8: Polish & Refinements
**Duration:** Week 6-7

- Add animations and transitions
- Implement accessibility features
- Add haptic feedback
- Error handling and retry logic
- Empty states and loading indicators
- Dark mode support (if not already)

### Phase 9: Backend Integration
**Duration:** Week 7-8

- Integrate Supabase Swift SDK
- Implement authentication with Supabase Auth
- Set up real-time sync
- Migrate from local-only to sync model
- Handle conflict resolution
- Add retry and error handling

### Phase 10: App Store Preparation
**Duration:** Week 9

- App Store screenshots
- App Store description and metadata
- Privacy policy
- Terms of service
- Final testing and bug fixes
- TestFlight beta testing
- App Store submission

## 7. Testing Strategy

### 7.1 Unit Tests

**Models:**
- Codable encoding/decoding
- Validation logic
- Business rules

**ViewModels:**
- State management
- Business logic
- Service interactions (mocked)

**Services:**
- API client responses
- Local storage operations
- Error handling

### 7.2 UI Tests

**Critical User Flows:**
- Sign up → Login → Dashboard
- Add entry → View entry → Edit entry → Delete entry
- Rating an entry
- Marking as watching
- Filtering and sorting

### 7.3 Test Coverage Goals

- **Unit Tests:** 80%+ coverage
- **UI Tests:** All critical flows
- **Integration Tests:** Service layer interactions

### 7.4 Testing Tools

- XCTest (built-in)
- XCUITest (built-in)
- Mock services for isolated testing

## 8. CI/CD Pipeline

### 8.1 GitHub Actions Workflow

**On Pull Request:**
```yaml
- Checkout code
- Set up Xcode environment
- Run SwiftLint
- Build app
- Run unit tests
- Run UI tests
- Report results
```

**On Merge to Main:**
```yaml
- All PR checks (above)
- Increment build number
- Build release variant
- Upload to TestFlight (Internal)
- Tag release in git
```

**Manual Triggers:**
- External TestFlight deployment
- App Store submission

### 8.2 Versioning

- **Semantic Versioning:** `MAJOR.MINOR.PATCH`
- **Build Numbers:** Auto-incremented on main merge
- **Git Tags:** Created for each TestFlight release

### 8.3 Environments

- **Debug:** Local development with mock data
- **Staging:** TestFlight internal with dev backend
- **Production:** App Store with production backend

## 9. Backend Integration (Supabase)

### 9.1 Supabase Services Used

- **Authentication:** Email/password auth
- **Database:** PostgreSQL for entries and user data
- **Real-time:** Live sync across devices
- **Storage:** Future: poster images, profile photos

### 9.2 Database Schema

**watched_entries table:**
```sql
id: uuid (primary key)
user_id: uuid (foreign key to auth.users)
title: text (max 200 chars)
type: text (enum: 'movie', 'tv_show')
rating: int (nullable, 1-3)
watched_date: date
notes: text (nullable, max 1000 chars)
watching: boolean (default false)
created_at: timestamptz
updated_at: timestamptz
```

### 9.3 Sync Strategy

**Offline-First Approach:**
1. All operations work locally first (CoreData)
2. Changes queued for sync when online
3. Background sync on network availability
4. Conflict resolution: last-write-wins with `updated_at`

### 9.4 Security

- Row Level Security (RLS) on all tables
- Users can only access their own data
- JWT tokens stored in iOS Keychain
- Token refresh handling

## 10. Security & Privacy

### 10.1 Data Security

- All API communication over HTTPS
- Auth tokens stored in Keychain (not UserDefaults)
- Biometric authentication option (Face ID/Touch ID)
- No sensitive data in logs
- Local data encrypted at rest (iOS default)

### 10.2 Privacy

- Minimal data collection
- Clear privacy policy
- User data deletion on request
- No third-party tracking
- App Tracking Transparency compliance

### 10.3 App Store Requirements

- Privacy nutrition label configuration
- Data usage declarations
- Third-party SDK disclosure

## 11. Performance Considerations

### 11.1 Optimization Goals

- **App Launch:** < 2 seconds to interactive
- **List Scrolling:** 60fps maintained
- **Network Requests:** < 1 second for CRUD operations
- **Offline Mode:** Instant feedback on all actions

### 11.2 Strategies

- Lazy loading for large lists
- Image caching (when images added)
- Background sync queue
- Optimistic UI updates
- Pagination for large datasets

## 12. Accessibility

### 12.1 Requirements

- VoiceOver support for all UI elements
- Dynamic Type support
- High contrast mode compatibility
- Voice Control support
- Minimum touch target size: 44x44pt

### 12.2 Implementation

- Semantic labels on all interactive elements
- Accessibility hints for complex interactions
- Screen reader announcements for state changes
- Keyboard navigation support (iPad)

## 13. Localization

### 13.1 Phase 1 (MVP)

- English only

### 13.2 Future

- Localization-ready string management
- Prepared for multiple languages
- Date/time formatting respects locale

## 14. Error Handling

### 14.1 Error Categories

- **Network Errors:** Retry logic, offline queue
- **Validation Errors:** Inline form errors
- **Auth Errors:** Clear messaging, logout handling
- **Sync Conflicts:** Automatic resolution with user notification

### 14.2 User Experience

- Non-blocking error messages
- Actionable error states
- Retry mechanisms
- Graceful degradation

## 15. Timeline Summary

| Phase | Duration | Status |
|-------|----------|--------|
| Phase 1: Foundation | Week 1 | In Progress |
| Phase 2: Core Architecture | Week 1-2 | Pending |
| Phase 3: Dashboard | Week 2-3 | Pending |
| Phase 4: CRUD Operations | Week 3-4 | Pending |
| Phase 5: Testing | Week 4 | Pending |
| Phase 6: CI/CD | Week 4-5 | Pending |
| Phase 7: Authentication | Week 5-6 | Pending |
| Phase 8: Polish | Week 6-7 | Pending |
| Phase 9: Backend Integration | Week 7-8 | Pending |
| Phase 10: App Store Prep | Week 9 | Pending |

**Total Estimated Timeline:** 9 weeks to App Store submission

## 16. Success Metrics

### 16.1 Technical Metrics

- Test coverage > 70%
- SwiftLint warnings = 0
- Crash-free rate > 99.5%
- App Store approval on first submission

### 16.2 Development Metrics

- All PRs pass CI before merge
- Code review on all changes
- Documentation for all public APIs
- Weekly progress updates

## 17. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Supabase integration complexity | High | Phase 9 late in timeline, can delay if needed |
| TestFlight approval delays | Medium | Start TestFlight setup early in Phase 6 |
| Scope creep | High | Strict phase definitions, defer features post-MVP |
| Apple guideline changes | Medium | Monitor App Store guidelines throughout |
| Code signing issues | Medium | Set up early, document process clearly |

## 18. Open Questions

1. Do we need iPad-specific layouts, or is iPhone layout scaled up acceptable?
2. Should we support social features (sharing, friends) in v1?
3. Do we want to integrate with external APIs (TMDB, IMDB) for movie/show metadata?
4. Should users be able to export their data (CSV, JSON)?
5. Do we need push notifications for any features?

## 19. Approval & Sign-off

This technical specification requires review and approval before Phase 2 execution begins.

**Reviewers:**
- [ ] Engineering Lead
- [ ] Product Owner
- [ ] Design Lead
- [ ] QA Lead

**Approval Date:** _________________

---

**Document Version History:**
- v1.0 (Nov 2025): Initial draft for team review
