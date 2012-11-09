/*
	Copyright (C) 2010 by BetterInbox <contact@betterinbox.com>
	Original author: Gregory Schlomoff <greg@betterinbox.com>

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/

#include "DeclarativeScrollingDropArea.h"
#include <math.h>
#include <qmath.h>
#include <algorithm>
#include <stdlib.h>

DeclarativeScrollingDropArea::DeclarativeScrollingDropArea(DeclarativeDropArea *parent)
	: DeclarativeDropArea(parent),
	m_view(0),
	m_timerId(0),
	m_scrollZone(0),
	m_lastEvent(0)
{
}

void DeclarativeScrollingDropArea::dragLeaveEvent(QGraphicsSceneDragDropEvent *event)
{
	stopTimer();
	DeclarativeDropArea::dragLeaveEvent(event);
}

void DeclarativeScrollingDropArea::dropEvent(QGraphicsSceneDragDropEvent *event)
{
	stopTimer();
	DeclarativeDropArea::dropEvent(event);
}

void DeclarativeScrollingDropArea::dragMoveEvent(QGraphicsSceneDragDropEvent *event)
{
	if (!view()) {
		qWarning() << "ScrollingDropArea: please set the 'view' property.";
		return;
	}

	double yOnFlickable = event->scenePos().y() - (view()->scenePos().y()); // scene-relative y-pos
	double yToCenter = view()->height() / 2 - yOnFlickable; // mouse distance to the center
	double zoneHeight = scrollZone() * 0.01 * view()->height(); // Height of the scrolling area
	double zoneToCenter = ( view()->height() / 2 ) - zoneHeight; // minimum distance to the center to start scrolling
	m_yInZone = abs(yToCenter) - zoneToCenter; // distance in the zone (how fast do we scroll?)
	if (m_yInZone > 0) {
			if (m_yInZone > zoneHeight) { // checking for bounds
				m_yInZone = zoneHeight;
			}
			m_yInZone = m_yInZone * yToCenter / abs(yToCenter);
			startTimer(16);
		} else {
			stopTimer();
		}

	DeclarativeDropArea::dragMoveEvent(event);

	// Store current event
	delete m_lastEvent;
	m_lastEvent = new DeclarativeDragDropEvent(event, this);
}

void DeclarativeScrollingDropArea::timerEvent(QTimerEvent*)
{
	double currentY = view()->property("contentY").toDouble();
	double yMove =  m_yInZone * 20 / (scrollZone() * 0.01 * view()->height()); // to get a normalized speed, whatever size of view we have
	double newContentY = currentY - yMove;

	if ((m_yInZone > 0 && view()->property("atYBeginning").toBool() != true)
			|| (m_yInZone < 0 && view()->property("atYEnd").toBool() != true)) { // Checking for bounds
		view()->setProperty("contentY", newContentY);

		// Emit scroll signal
		if (m_lastEvent) {
			emit dragScroll(m_lastEvent);
		}
	}
}

void DeclarativeScrollingDropArea::startTimer(int interval)
{
	if (m_timerId == 0) {
		m_timerId = QObject::startTimer(interval);
	}
}

void DeclarativeScrollingDropArea::stopTimer()
{
	if (m_timerId != 0) {
		QObject::killTimer(m_timerId);
		m_timerId = 0;
	}
}

QDeclarativeItem* DeclarativeScrollingDropArea::view() const
{
	return m_view;
}
void DeclarativeScrollingDropArea::setView(QDeclarativeItem* view)
{
	if (m_view != view) {
		m_view = view;
		emit viewChanged();
	}
}

int DeclarativeScrollingDropArea::scrollZone() const
{
	return m_scrollZone;
}
void DeclarativeScrollingDropArea::setScrollZone(int scrollZone)
{

	if (scrollZone != m_scrollZone) {
		m_scrollZone = scrollZone;
		emit scrollZoneChanged();
	}
}
