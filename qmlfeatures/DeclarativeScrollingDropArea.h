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

#ifndef DECLARATIVESCROLLINGDROPAREA_H
#define DECLARATIVESCROLLINGDROPAREA_H

#include "DeclarativeDropArea.h"

class DeclarativeScrollingDropArea : public DeclarativeDropArea
{
	Q_OBJECT
	Q_PROPERTY(QDeclarativeItem* view READ view WRITE setView NOTIFY viewChanged)
	Q_PROPERTY(int scrollZone READ scrollZone WRITE setScrollZone NOTIFY scrollZoneChanged)

public:
	DeclarativeScrollingDropArea(DeclarativeDropArea *parent=0);
	QDeclarativeItem* view() const;
	void setView(QDeclarativeItem* view);
	int scrollZone() const;
	void setScrollZone(int scrollZone);

signals:
	void viewChanged();
	void scrollZoneChanged();
	void dragScroll(DeclarativeDragDropEvent* event);

protected:
	void dragLeaveEvent(QGraphicsSceneDragDropEvent *event);
	void dropEvent(QGraphicsSceneDragDropEvent *event);
	void dragMoveEvent(QGraphicsSceneDragDropEvent *event);
	void timerEvent(QTimerEvent *event);
	void startTimer(int interval);
	void stopTimer();

private:
	QDeclarativeItem* m_view;
	int m_timerId;
	int m_scrollZone;
	double m_yInZone;
	DeclarativeDragDropEvent* m_lastEvent;
};

#endif // DECLARATIVESCROLLINGDROPAREA_H
